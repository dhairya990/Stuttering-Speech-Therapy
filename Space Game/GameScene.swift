//  GameScene.swift
//  SpaceGame
//
//  Created by Sambhav Singh on 18/05/24.
//


import UIKit
import SpriteKit
import GameplayKit
import Speech





var gameScore = 0

class GameScene: SKScene, SKPhysicsContactDelegate,SFSpeechRecognizerDelegate{

    let wordsArray = ["Hello" ,"World","Moon","Sun","Fire","Rain"]
    var gameViewController = GameViewController?.self
    var levelNumber = 0
   
    let scoreLabel = SKLabelNode(fontNamed: "BOLDFONT")

    var livesNumber = 10
    let liveLables = SKLabelNode(fontNamed: "BOLDFONT")
    var thisDelegate: backButtonDelegate!
    
    


    struct PhysicsCategories{
        static let none : UInt32 = 0
        static let player : UInt32 = 0b1
        static let bullet : UInt32 = 0b10
        static let enemy : UInt32 = 0b100
    }


    let player = SKSpriteNode(imageNamed: "playerShip")

    let gameArea:CGRect



    enum gameState {
        case preGame
        case inGame
        case postGame
    }

    var currentGameState = gameState.inGame



    func random()-> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }

    func random(min: CGFloat,max: CGFloat)-> CGFloat{
        return random() * (max - min) + min
    }







    override init(size: CGSize) {


        let screenSize = UIScreen.main.bounds.size
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height

        let maxAspectRatio: CGFloat = screenHeight / screenWidth


        let playableWidth = size.height / maxAspectRatio
        let margin = (size.width - playableWidth) / 2
        gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)



        super.init(size: size)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    



    override func didMove(to view: SKView) {
        
        gameScore = 0
      //  currentGameState = .inGame

        self.physicsWorld.contactDelegate = self

        
        for i in 0...1{
            let background = SKSpriteNode(imageNamed: "background")
            background.name = "Background"
            background.size=self.size
            background.anchorPoint=CGPoint(x: 0.5, y: 0)
            background.position=CGPoint(x: self.size.width/2, y: self.size.height*CGFloat(i))
            background.zPosition=0
            self.addChild(background)
        }

        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody!.affectedByGravity = false

        player.setScale(1)
        player.position=CGPoint(x: self.size.width/2, y: self.size.height*0.2)
        player.zPosition=2
        player.physicsBody?.categoryBitMask = PhysicsCategories.player
        player.physicsBody?.collisionBitMask=PhysicsCategories.none
        player.physicsBody?.contactTestBitMask=PhysicsCategories.enemy
        self.addChild(player)


        scoreLabel.text = "Score : 0"
        scoreLabel.fontSize = 70
        scoreLabel.fontColor = SKColor.white
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLabel.position = CGPoint(x: self.size.width*0.20, y: self.size.height*0.9)
        scoreLabel.zPosition = 50
        self.addChild(scoreLabel)


        liveLables.text = "Lives : 10"
        liveLables.fontSize = 70
        liveLables.fontColor = SKColor.white
        liveLables.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        liveLables.position = CGPoint(x: self.size.width*0.80, y: self.size.height*0.9)
        liveLables.zPosition = 50
        self.addChild(liveLables)

        startNewLevel()
        spawnWord()

    }
    
    

    func decreaseLive(){
        livesNumber -= 1
        liveLables.text = "Lives : \(livesNumber)"
        if livesNumber == 0 {
            gameOver()
        }
    }



    func addScore(){
        gameScore += 1
        scoreLabel.text = "score : \(gameScore)"
    }

    func didBegin(_ contact: SKPhysicsContact) {
        var body1 = SKPhysicsBody()
        var body2 = SKPhysicsBody()

        if contact.bodyA.categoryBitMask<contact.bodyB.categoryBitMask{
            body1 = contact.bodyA
            body2=contact.bodyB
        }
        else {
            body1 = contact.bodyB
            body2 = contact.bodyA
        }

        if body1.categoryBitMask == PhysicsCategories.player && body2.categoryBitMask == PhysicsCategories.enemy{

            if body1.node != nil {
                spawnExplosion(spawnPosition: body1.node!.position)
            }

            if body2.node != nil {
                spawnExplosion(spawnPosition: body2.node!.position)
            }

            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
            gameOver()
        }
        if body1.categoryBitMask == PhysicsCategories.bullet && body2.categoryBitMask == PhysicsCategories.enemy {

            
            if body2.node != nil {
                if body2.node!.position.y > self.size.height{
                    return
                }
                else{
                    spawnExplosion(spawnPosition: body2.node!.position)
                    addScore()
                }
                //spawnExplosion(spawnPosition: body2.node!.position)
            }

            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
        }

    }

    var lastUpdateTime : TimeInterval = 0
    var deltaFrameTime : TimeInterval = 0
    var amountToMovePersond : CGFloat = 400.0
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime == 0 {
            lastUpdateTime = currentTime
        }else {
            deltaFrameTime = currentTime - lastUpdateTime
            lastUpdateTime = currentTime
        }

        let amountToMovebackground = amountToMovePersond*CGFloat(deltaFrameTime)

        self.enumerateChildNodes(withName: "Background") { background, stop in


            if self.currentGameState == gameState.inGame{
                background.position.y -= amountToMovebackground
            }
            if background.position.y < -self.size.height{
                background.position.y += self.size.height*2
            }
        }
    }






    func spawnExplosion(spawnPosition:CGPoint){
        let explosion = SKSpriteNode(imageNamed: "explosion")
        explosion.position=spawnPosition
        explosion.zPosition=3
        explosion.setScale(0)
        self.addChild(explosion)


        let scaleIn = SKAction.scale(to: 1, duration: 0.1)
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let delete = SKAction.removeFromParent()
        let exposionSecquence = SKAction.sequence([scaleIn,fadeOut,delete])

        explosion.run(exposionSecquence)
    }


    func startNewLevel(){
        let spawn = SKAction.run(spawnEnemy)
        let words = SKAction.run(spawnWord)
        let waitToSpawn = SKAction.wait(forDuration: 5)
        let waitForRocket = SKAction.wait(forDuration: 3)
        let spawnSequence = SKAction.sequence([waitToSpawn , words])
        let spawnAnotherSecquence = SKAction.sequence([waitForRocket , spawn])
        let spawnForever = SKAction.repeatForever(spawnSequence)
        let spawnForever2 = SKAction.repeatForever(spawnAnotherSecquence)
        self.run(spawnForever)
        self.run(spawnForever2)
    }
    
    func spawnWord() {
            let randomXStart = random(min: gameArea.minX, max: gameArea.maxX)
            
            let startPoint = CGPoint(x: randomXStart, y: self.size.height * 1.2)
        
           let randomWord = wordsArray.randomElement()!
            
            let wordLabel = SKLabelNode(text: randomWord)
            
            wordLabel.fontSize = 70
            wordLabel.fontColor = SKColor.white
            wordLabel.position = startPoint
            wordLabel.zPosition = 5
            wordLabel.name = "Word"
            wordLabel.fontName = "BOLDFONT"
            
            wordLabel.physicsBody = SKPhysicsBody(rectangleOf: wordLabel.frame.size)
            wordLabel.physicsBody!.affectedByGravity = false
            wordLabel.physicsBody?.categoryBitMask = PhysicsCategories.enemy
            wordLabel.physicsBody?.collisionBitMask = PhysicsCategories.none
            wordLabel.physicsBody?.contactTestBitMask = PhysicsCategories.bullet | PhysicsCategories.player
            self.addChild(wordLabel)
        
            
            let moveWord = SKAction.move(to: CGPoint(x: random(min: gameArea.minX, max: gameArea.maxX), y: -self.size.height * 0.2), duration: 5)
            let deleteWord = SKAction.removeFromParent()
            let loseALife = SKAction.run(decreaseLive)
            let wordSequence = SKAction.sequence([moveWord, deleteWord, loseALife])
            wordLabel.run(wordSequence)
        }



    func gameOver(){

        currentGameState = gameState.postGame
        self.removeAllActions()
        self.enumerateChildNodes(withName: "Bullet") { bullet,stop in
            bullet.removeAllActions()
        }

        self.enumerateChildNodes(withName: "Enemy") { enemy, stop in
            enemy.removeAllActions()
        }
        
        let changeSceneAction = SKAction.run(changeScene)
        let waitToChangeScene = SKAction.wait(forDuration: 1)
        let changeSceneSequences = SKAction.sequence([waitToChangeScene,changeSceneAction])
        self.run(changeSceneSequences)
        
       

    }
    
    
    func changeScene(){
        let sceneMoveTo = GameOverScene(size: self.size)
        sceneMoveTo.scaleMode = self.scaleMode
        sceneMoveTo.gameOverDelegate = thisDelegate
        let myTransition = SKTransition.fade(withDuration: 0.5)
        self.view!.presentScene(sceneMoveTo, transition: myTransition)
    }


    func fireBullet(){
        let bullet = SKSpriteNode(imageNamed: "bullet")
        bullet.name = "Bullet"
        bullet.setScale(1)
        bullet.position=player.position
        bullet.zPosition=10
        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size)
        bullet.physicsBody!.affectedByGravity = false
        bullet.physicsBody?.categoryBitMask=PhysicsCategories.bullet
        bullet.physicsBody?.collisionBitMask=PhysicsCategories.none
        bullet.physicsBody?.contactTestBitMask=PhysicsCategories.enemy
        self.addChild(bullet)

        let moveBullet = SKAction.moveTo(y: self.size.height + bullet.size.height, duration: 1)
        let deleteBullet = SKAction.removeFromParent()
        let bulletSecquence = SKAction.sequence([moveBullet,deleteBullet])
        bullet.run(bulletSecquence)



    }

    func spawnEnemy(){
        let randomXStart = random(min: CGRectGetMinX(gameArea), max: CGRectGetMaxX(gameArea))
        let randomXEnd = random(min: CGRectGetMinX(gameArea), max: CGRectGetMaxX(gameArea))

        let startPoint = CGPoint(x: randomXStart, y: self.size.height * 1.2)
        let endpoint = CGPoint(x: randomXEnd, y: -self.size.height * 0.2)



        let enemy = SKSpriteNode(imageNamed: "enemyShip")
        enemy.name = "Enemy"
        enemy.setScale(1)
        enemy.position = startPoint
        enemy.zPosition = 2
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody!.affectedByGravity = false
        enemy.physicsBody?.categoryBitMask=PhysicsCategories.enemy
        enemy.physicsBody?.collisionBitMask = PhysicsCategories.none
        enemy.physicsBody?.contactTestBitMask = PhysicsCategories.player | PhysicsCategories.bullet
        self.addChild(enemy)

        let moveEnemy = SKAction.move(to: endpoint, duration: 5)
        let deleteEnemy = SKAction.removeFromParent()
        let loseALife =  SKAction.run(decreaseLive)
        let enemySequence = SKAction.sequence([moveEnemy,deleteEnemy,loseALife])
        enemy.run(enemySequence)


        let dx = endpoint.x - startPoint.x
        let dy = endpoint.y - startPoint.y
        let amountToRotate = atan2(dy, dx)
        enemy.zRotation = amountToRotate






    }







    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //fireBullet()
    }


    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch:AnyObject in touches{
            let pointOfTouch = touch.location(in: self)
            let previousPointOfTouch = touch.previousLocation(in: self)


            let amountDragged = pointOfTouch.x - previousPointOfTouch.x

            if currentGameState == gameState.inGame{
                player.position.x += amountDragged
            }

            if player.position.x >= gameArea.maxX - player.size.width/2 {
                         player.position.x = gameArea.maxX - player.size.width/2
                     }

            if player.position.x <= gameArea.minX + player.size.width/2 {
                    player.position.x = gameArea.minX + player.size.width/2
            }
        }
    }

}
