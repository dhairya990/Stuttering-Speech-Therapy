//  GameOverScene.swift
//  SpaceGame
//
//  Created by Sambhav Singh on 18/05/24.
//



import Foundation
import SpriteKit
import UIKit

protocol backButtonDelegate:AnyObject{
    func didHomeTap()
}

class GameOverScene : SKScene {
    weak var gameOverDelegate: (backButtonDelegate)?
    let restartlabel = SKLabelNode(fontNamed: "BOLDFONT")
    
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        
        let gameOverLabel = SKLabelNode(fontNamed: "BOLDFONT")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 170
        gameOverLabel.fontColor = SKColor.white
        gameOverLabel.zPosition = 1
        gameOverLabel.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.7)
        self.addChild(gameOverLabel)
        
        
        let scoreLabels = SKLabelNode(fontNamed: "BOLDFONT")
        scoreLabels.text = "Score : \(gameScore)"
        scoreLabels.fontSize = 55
        scoreLabels.fontColor = SKColor.white
        scoreLabels.zPosition = 1
        scoreLabels.position = CGPoint(x: self.size.width/2, y: self.size.height*0.55)
        self.addChild(scoreLabels)
        
        
        let defaults = UserDefaults()
        var highScore = defaults.integer(forKey: "highScoreSaved")
        
        if gameScore > highScore{
            highScore = gameScore
            defaults.set(highScore, forKey: "highScoreSaved")
        }
        
        let highScoreLabel = SKLabelNode(fontNamed: "BOLDFONT")
        highScoreLabel.fontColor = SKColor.white
        highScoreLabel.fontSize = 100
        highScoreLabel.text = "High Score : \(highScore)"
        highScoreLabel.zPosition = 1
        highScoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.45)
        self.addChild(highScoreLabel)
        
        
        restartlabel.text = "Back"
        restartlabel.fontSize = 80
        restartlabel.fontColor = SKColor.white
        restartlabel.zPosition = 1
        restartlabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.3)
        self.addChild(restartlabel)
        
    }
    
       
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch : AnyObject in touches{
            let pointTouches = touch.location(in: self)
            if restartlabel.contains(pointTouches){
                gameOverDelegate?.didHomeTap()
                }
            }
        }
    }
