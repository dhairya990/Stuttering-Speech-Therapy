//
//  DailyExerciseViewController.swift
//  ExerciseNew5
//
//  Created by Dhairya bhardwaj on 03/06/24.
//

import UIKit
import AVFoundation
class DailyExerciseViewController: UIViewController {
    

    var audioFileURLs: [URL] = []
     var imageLabelItem: ImageLabelItem?
     var audioPlayer: AVPlayer?
     var isPlaying = false
     var currentAudioIndex = 0
     var audioVisualizer: CAShapeLayer?
     
     let audioLabel = UILabel()
     let playButton = UIButton(type: .system)
     let nextButton = UIButton(type: .system)
     var playerLayer: AVPlayerLayer?
     
     override func viewDidLoad() {
     super.viewDidLoad()
     setupUI()
     setupVideoPlayer()
     updateUIForCurrentAudio()
     //setupAudioVisualizer()
     }
     
     private func setupUI() {
         let customColor = UIColor(red: 229/255, green: 229/255, blue: 252/255, alpha: 1.0) // Example color
                 view.backgroundColor = customColor
     
     audioLabel.translatesAutoresizingMaskIntoConstraints = false
     view.addSubview(audioLabel)
     
     playButton.setTitle("Play", for: .normal)
     playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
     playButton.translatesAutoresizingMaskIntoConstraints = false
     view.addSubview(playButton)
     
     nextButton.setTitle("Next", for: .normal)
     nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
     nextButton.translatesAutoresizingMaskIntoConstraints = false
     view.addSubview(nextButton)
     
     NSLayoutConstraint.activate([
     audioLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
     audioLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150),
     
     playButton.topAnchor.constraint(equalTo: audioLabel.bottomAnchor, constant: 20),
     playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
     
     nextButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 20),
     nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
     ])
     }
     
    private func setupVideoPlayer() {
       guard let imageLabelItem = imageLabelItem else {
           print("Error: imageLabelItem is nil")
           return
       }
       
       // Check if currentAudioIndex is within bounds
       guard currentAudioIndex >= 0 && currentAudioIndex < imageLabelItem.audioFileURLs.count else {
           print("Error: currentAudioIndex \(currentAudioIndex) is out of bounds for audioFileURLs count \(imageLabelItem.audioFileURLs.count)")
           return
       }
       
       let audioURL = imageLabelItem.audioFileURLs[currentAudioIndex]
       print("Setting up video player with URL: \(audioURL)") // Logging
    
    // Check if currentAudioIndex is within bounds
    guard currentAudioIndex >= 0 && currentAudioIndex < imageLabelItem.audioFileURLs.count else {
        print("Error: currentAudioIndex \(currentAudioIndex) is out of bounds for audioFileURLs count \(imageLabelItem.audioFileURLs.count)")
        return
    }
    

    audioPlayer = AVPlayer(url: audioURL)
    playerLayer = AVPlayerLayer(player: audioPlayer)
    playerLayer?.frame = CGRect(x: 0, y: 0, width: view.bounds.width / 2, height: view.bounds.height / 2)
    playerLayer?.position = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
    if let playerLayer = playerLayer {
        view.layer.addSublayer(playerLayer)
    }
}
 
 private func updateVideoPlayer() {
     guard let imageLabelItem = imageLabelItem else { return }
     let audioURL = imageLabelItem.audioFileURLs[currentAudioIndex]
     
     audioPlayer?.pause()
     playerLayer?.removeFromSuperlayer()
     
     audioPlayer = AVPlayer(url: audioURL)
     playerLayer = AVPlayerLayer(player: audioPlayer)
     playerLayer?.frame = CGRect(x: 0, y: 0, width: view.bounds.width / 2, height: view.bounds.height / 2)
     playerLayer?.position = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
     if let playerLayer = playerLayer {
     view.layer.addSublayer(playerLayer)
     }
     
     if isPlaying {
     audioPlayer?.play()
     }
 }
 
 @objc private func playButtonTapped() {
     toggleAudioPlayback()
 }
 
 @objc private func nextButtonTapped() {
     moveToNextAudio()
 }
 
 private func updateUIForCurrentAudio() {
     guard let imageLabelItem = imageLabelItem else { return }
     let audioURL = imageLabelItem.audioFileURLs[currentAudioIndex]
    // audioLabel.text = "Audio \(currentAudioIndex + 1): \(audioURL.lastPathComponent)"
     playButton.setTitle("Play", for: .normal)
     isPlaying = false
     audioPlayer?.pause()
 }
 
private func toggleAudioPlayback() {
        if isPlaying {
            audioPlayer?.pause()
            playButton.setTitle("Play", for: .normal)
        } else {
            if audioPlayer == nil, currentAudioIndex < audioFileURLs.count {
                let audioURL = audioFileURLs[currentAudioIndex]
                audioPlayer = AVPlayer(url: audioURL)
                playerLayer = AVPlayerLayer(player: audioPlayer)
                playerLayer?.frame = CGRect(x: 0, y: 0, width: view.bounds.width / 2, height: view.bounds.height / 2)
                playerLayer?.position = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
                if let playerLayer = playerLayer {
                    view.layer.addSublayer(playerLayer)
                }
            }
            audioPlayer?.play()
            playButton.setTitle("Pause", for: .normal)
        }
        isPlaying.toggle()
    }

 
 private func moveToNextAudio() {
     guard let imageLabelItem = imageLabelItem else { return }
     currentAudioIndex = (currentAudioIndex + 1) % imageLabelItem.audioFileURLs.count
     updateUIForCurrentAudio()
     updateVideoPlayer()
     // startAudioVisualizer()
     }
 }
 

