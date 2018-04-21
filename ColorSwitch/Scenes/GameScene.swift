//
//  GameScene.swift
//  ColorSwitch
//
//  Created by Anthony Da Cruz on 10/03/2018.
//  Copyright © 2018 Anthony Da Cruz. All rights reserved.
//

import SpriteKit

enum PlayColors {
    static let colors = [
        UIColor(r: 231, g: 76, b: 60, a: 1.0),
        UIColor(r: 241, g: 196, b: 15, a: 1.0),
        UIColor(r: 46, g: 204, b: 113, a: 1.0),
        UIColor(r: 52, g: 152, b: 219, a: 1.0),
    ]
}

enum SwitchState: Int {
    case red, yellow, green, blue
}

class GameScene: SKScene {
    
    var colorSwitch:SKSpriteNode!
    var switchState = SwitchState.red
    var currentColorIndex: Int?
    
    let scoreLabel = SKLabelNode(text: "0")
    var score = 0
    
    override func didMove(to view: SKView) {
        self.layoutScene()
        self.spawnBall()
        self.setupPhysics()
    }
    
    func setupPhysics() {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -3.0)
        self.physicsWorld.contactDelegate = self
    }
    
    func layoutScene() {
        self.backgroundColor = GameColors.generalBackgroundColor
        self.colorSwitch = SKSpriteNode(imageNamed: "ColorCircle")
        self.colorSwitch.size = CGSize(width: frame.size.width/3, height: frame.size.width/3)
        self.colorSwitch.position = CGPoint(x: frame.midX, y: frame.minY + self.colorSwitch.size.height + 5)
        self.colorSwitch.zPosition = ZPositions.colorCircle
        self.colorSwitch.physicsBody = SKPhysicsBody(circleOfRadius: self.colorSwitch.size.height/2)
        self.colorSwitch.physicsBody?.categoryBitMask = PhysicsCategories.switchCategory
        self.colorSwitch.physicsBody?.isDynamic = false
        
        self.scoreLabel.fontName = "AvenirNext-Bold"
        self.scoreLabel.zPosition = ZPositions.label
        self.scoreLabel.fontSize = 60.0
        self.scoreLabel.fontColor = GameColors.scoreFontColor
        self.scoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        self.addChild(self.scoreLabel)
        self.addChild(self.colorSwitch)
    }
    
    func updateScoreLabel() {
        scoreLabel.text = "\(self.score)"
    }
    
    func spawnBall() {
        self.currentColorIndex = Int(arc4random_uniform(UInt32(4))) //Thanks swift
        
        let ball = SKSpriteNode(texture: SKTexture(imageNamed: "ball"), color: PlayColors.colors[self.currentColorIndex!], size: CGSize(width: 30, height: 30))
        ball.zPosition = ZPositions.ball
        ball.colorBlendFactor = 1.0
        ball.name = "Ball"
        ball.position = CGPoint(x: frame.midX, y: frame.maxY - ball.size.height/2 - SKScene.topNotchHeight)
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.height/2)
        ball.physicsBody?.categoryBitMask = PhysicsCategories.ballCategory
        ball.physicsBody?.contactTestBitMask = PhysicsCategories.switchCategory
        ball.physicsBody?.collisionBitMask = PhysicsCategories.none
        
        self.addChild(ball)
    }
    
    func gameOver() {
        UserDefaults.standard.set(self.score, forKey: "recentScore")
        
        
            if UserDefaults.standard.integer(forKey: "bestScore") < self.score {
                UserDefaults.standard.set(self.score, forKey: "bestScore")
            }
        
        
        let menuScene = MenuScene(size: view!.bounds.size)
        view!.presentScene(menuScene)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        let location = touch?.location(in: self.colorSwitch)
        
        self.turnWheel()
    }
    
    func turnWheel() {
        if let newState = SwitchState(rawValue: switchState.rawValue + 1){
            self.switchState = newState
        }else {
            self.switchState = .red
        }
        
        self.colorSwitch.run(SKAction.rotate(byAngle: .pi/2, duration: 0.25))
        print(self.switchState)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        // 01
        // 10
        // 11
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if contactMask == PhysicsCategories.ballCategory | PhysicsCategories.switchCategory {
            if let ball = (contact.bodyA.node?.name == "Ball" ? contact.bodyA.node as? SKSpriteNode : contact.bodyB.node as? SKSpriteNode) {
                if currentColorIndex == self.switchState.rawValue {
                    let tapticEngine = UIImpactFeedbackGenerator()
                    tapticEngine.impactOccurred()
                    run(SKAction.playSoundFileNamed("bling", waitForCompletion: false))
                    self.score += 1
                    self.updateScoreLabel()
                    ball.run(SKAction.fadeOut(withDuration: 0.15), completion: {
                        ball.removeFromParent()
                        self.spawnBall()
                    })
                }else {
                    self.gameOver()
                    
                }
            }
        }
    }
}
