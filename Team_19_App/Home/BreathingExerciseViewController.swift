//
//  BreathingExerciseViewController.swift
//  breathingExercise
//
//  Created by Dhairya bhardwaj on 27/05/24.
//

import UIKit

class BreathingExerciseViewController: UIViewController {
    let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Breathe In"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let circleView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.systemPurple
        view.layer.cornerRadius = 100
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Stop", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var isAnimating = false

override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    view.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 252/255, alpha: 1.0)
        setupUI()
    }
    
    func setupUI() {
        // Add instructionLabel to the view
        view.addSubview(instructionLabel)
        
        // Add circleView to the view
        view.addSubview(circleView)
        
        // Add startButton to the view
        view.addSubview(startButton)
        
        // Add stopButton to the view
        view.addSubview(stopButton)
        
        // Set up constraints for instructionLabel
        NSLayoutConstraint.activate([
            instructionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instructionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ])
        
        // Set up constraints for circleView
        NSLayoutConstraint.activate([
            circleView.widthAnchor.constraint(equalToConstant: 200),
            circleView.heightAnchor.constraint(equalToConstant: 200),
            circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Set up constraints for startButton
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 50)
        ])
        
        // Set up constraints for stopButton
        NSLayoutConstraint.activate([
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 20)
        ])
    }
    
    @objc func startButtonTapped() {
        guard !isAnimating else { return }
        isAnimating = true
        startBreathingExercise()
    }
    
    @objc func stopButtonTapped() {
        isAnimating = false
        instructionLabel.text = "Breathe In"
        circleView.layer.removeAllAnimations()
        circleView.transform = .identity
    }
    
    func startBreathingExercise() {
        if isAnimating {
            breatheIn()
        }
    }
    
    func breatheIn() {
        instructionLabel.text = "Breathe In"
        UIView.animate(withDuration: 8.0, animations: {
            self.circleView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { _ in
            if self.isAnimating {
                self.breatheOut()
            }
        }
    }
    
    func breatheOut() {
        instructionLabel.text = "Breathe Out"
        UIView.animate(withDuration: 4.0, animations: {
            self.circleView.transform = CGAffineTransform.identity
        }) { _ in
            if self.isAnimating {
                self.breatheIn()
            }
        }
    }
}
    


