//
//  RecordingPageViewController.swift
//  Team_19_App
//
//  Created by Sambhav Singh on 22/05/24.
//

import UIKit
import AVFoundation
import CoreML
import Accelerate
import Speech


class RecordingPageViewController: UIViewController,SFSpeechRecognizerDelegate, RecordButtonDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate  {
    
    
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    var recordingSession: AVAudioSession!
    var model: Fluency__1?
    
    var weekDay: WeekDay {
        let dateIndex = (Calendar.current.component(.weekday, from: Date()) + 5) % 7
        return weekDays[dateIndex]
    }
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var predictButton: UIButton!
    
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    func tapButton(isRecording: Bool) {
        if isRecording {
            try! startRecording()
        } else {
            stopRecording()
        }
    }
    
    var recordButton: RecordButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        speechRecognizer?.delegate = self
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.setupRecorder()
                    } else {
                        self.statusLabel.text = "Microphone access denied"
                    }
                }
            }
        } catch {
            statusLabel.text = "Failed to setup audio session"
        }
        
        // Load the ML model
        do {
            model = try Fluency__1(configuration: MLModelConfiguration())
        } catch {
            statusLabel.text = "Failed to load the model"
        }
        //try! startRecording()
    }
    
    
    func stopRecording(){
        audioEngine.stop()
        audioRecorder?.stop()
        //recordButton.setTitle("Record", for: .normal)
        statusLabel.text = "Recording stopped"
        playButton.isEnabled = true
        audioEngine.inputNode.removeTap(onBus: 0)
        //predictButton.isEnabled = true
    }
    
    func audioToMultiArray(url: URL) -> MLMultiArray? {
        // Load audio file
        let audioFile = try? AVAudioFile(forReading: url)
        guard let file = audioFile else { return nil }
        
        let format = file.processingFormat
        let frameCount = AVAudioFrameCount(file.length)
        let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameCount)!
        
        try? file.read(into: buffer)
        
        // Get audio data from buffer
        guard let floatChannelData = buffer.floatChannelData else { return nil }
        let channelData = floatChannelData.pointee
        
        // Downsample or trim the audio data to fit into MLMultiArray
        let requiredSampleCount = 15600
        let sampleRate = Int(format.sampleRate)
        let totalSamples = Int(buffer.frameLength)
        
        // Ensure the requiredSampleCount is less than or equal to totalSamples
        guard requiredSampleCount <= totalSamples else { return nil }
        
        var samples = [Float](repeating: 0.0, count: requiredSampleCount)
        
        let stride = totalSamples / requiredSampleCount
        for i in 0..<requiredSampleCount {
            samples[i] = channelData[i * stride]
        }

        // Create MLMultiArray
        let multiArray = try? MLMultiArray(shape: [requiredSampleCount] as [NSNumber], dataType: .float32)
        guard let mlArray = multiArray else { return nil }
        
        // Copy the processed samples to the MLMultiArray
        for (index, sample) in samples.enumerated() {
            mlArray[index] = NSNumber(value: sample)
        }
        
        return mlArray
    }
    
    func setupRecorder() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.prepareToRecord()
        } catch {
            statusLabel.text = "Failed to setup recorder"
        }
    }
    
    func startRecording() throws{
          if recognitionTask != nil {
              recognitionTask?.cancel()
              recognitionTask = nil
          }
    
            audioRecorder?.record()
            statusLabel.text = "Recording in progress"

          let audioSession = AVAudioSession.sharedInstance()
          try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
          try audioSession.setActive(true, options: .notifyOthersOnDeactivation)

          recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
          guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }

          let inputNode = audioEngine.inputNode
          recognitionRequest.shouldReportPartialResults = true

        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { [self] result, error in
              var isFinal = false

              if let result = result {
                  //self.textView.text = result.bestTranscription.formattedString
                  self.textView.text = result.bestTranscription.formattedString
                  
              }

              if error != nil || isFinal {
                  self.audioEngine.stop()
                  inputNode.removeTap(onBus: 0)

                  self.recognitionRequest = nil
                  self.recognitionTask = nil

              }
          }

          let recordingFormat = inputNode.outputFormat(forBus: 0)
          inputNode.removeTap(onBus: 0)
          inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, when in
              self.recognitionRequest?.append(buffer)
          }
          audioEngine.prepare()
          try audioEngine.start()
        
          textView.text = "Say something, I'm listening!"
      }
    
    
    
    @IBAction func playTapped(_ sender: UIButton) {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            audioPlayer?.delegate = self
            audioPlayer?.play()
            statusLabel.text = "Playing audio"
        } catch {
            statusLabel.text = "Playback failed"
        }
    }
    
    func increaseStutterCount() {
        var stutterCount = DataController.shared.getStutterCount(for: weekDay)
        stutterCount += 1
        DataController.shared.setStutterCount(to: stutterCount, for: weekDay)
    }
    
    func increaseNoStutterCount() {
        var noStutterCount = DataController.shared.getNoStutterCount(for: weekDay)
        noStutterCount += 1
        DataController.shared.setNoStutterCount(to: noStutterCount, for: weekDay)
    }
    
    @IBAction func predictTapped(_ sender: UIButton) {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        
        guard let audioMultiArray = audioToMultiArray(url: audioFilename) else {
            statusLabel.text = "Failed to convert audio to MLMultiArray"
            increaseStutterCount()
            return
        }
        
        // Create the model input
        let input = Fluency__1Input(audioSamples: audioMultiArray)
        
        // Make the prediction
        do {
            guard let prediction = try model?.prediction(input: input) else {
                statusLabel.text = "Failed to make prediction!"
                increaseStutterCount()
                return
            }
            
            statusLabel.text = "Prediction: \(prediction.target)"
            
            
            if statusLabel.text == "Prediction: NoStutteredWords"{
                increaseNoStutterCount()
            } else {
                increaseStutterCount()
            }
            
        } catch {
            statusLabel.text = "Failed to make prediction!"
            increaseStutterCount()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        let recordButtonSide = self.view.bounds.size.height/10
        recordButton = RecordButton(frame: CGRect(x: self.view.bounds.width/2-recordButtonSide/2,
                                                  y: self.view.bounds.height/1.15-recordButtonSide,
                                                  width: recordButtonSide,
                                                  height: recordButtonSide))
        recordButton?.delegate = self
        
        self.view.addSubview(recordButton!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
           try! startRecording()
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        statusLabel.text = "Playback finished"
    }
}


