//  GameViewController.swift
//  SpaceGame
//
//  Created by Sambhav Singh on 18/05/24.
//



import UIKit
import SpriteKit
import GameplayKit
import Speech

protocol GameViewControllerDelegate: AnyObject {
    func restartGame()
}



class GameViewController: UIViewController, SFSpeechRecognizerDelegate, SKPhysicsContactDelegate, GameViewControllerDelegate ,backButtonDelegate {
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    var gameScene: GameScene?
    var text: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speechRecognizer?.delegate = self
        try! startRecording()
        startGame()
    }
    
    func startGame() {
        if let view = self.view as? SKView {
            let scene = GameScene(size: CGSize(width: 1536, height: 2048))
            scene.thisDelegate = self
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            gameScene = scene
            
        }
    }
    
    func restartGame() {
        stopAudioEngine()
        startGame()
        try! startRecording()
        print("Restart game started started")
        
    }
    
    func stopAudioEngine() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
    }
    
    
    func didHomeTap(){
            print("call")
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func startRecording() throws {
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }

        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object") }

        let inputNode = audioEngine.inputNode
        recognitionRequest.shouldReportPartialResults = true

        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { [weak self] result, error in
            guard let self = self else { return }
            var isFinal = false

            if let result = result {
                self.text = result.bestTranscription.formattedString
                print("Recognized text: \(self.text)")
                
                
                for word in self.gameScene!.wordsArray{
                    if self.gameScene!.wordsArray.contains(word) == true {
                        self.gameScene?.fireBullet()
                       
                    }
                }
                
                isFinal = result.isFinal
            }

            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        }

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, when in
            self.recognitionRequest?.append(buffer)
        }

        audioEngine.prepare()
        try audioEngine.start()
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
