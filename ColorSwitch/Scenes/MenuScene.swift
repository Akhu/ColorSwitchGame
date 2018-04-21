//
//  MenuScene.swift
//  ColorSwitch
//
//  Created by Anthony Da Cruz on 10/03/2018.
//  Copyright © 2018 Anthony Da Cruz. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        self.layoutScene()
        
    }
    
    func layoutScene() {
        self.addLogo()
        self.addLabels()
    }
    
    func addLogo() {
        let logo = SKSpriteNode(imageNamed: "logo")
        logo.size = CGSize(width: self.frame.size.width/4, height: self.frame.size.width/4)
        logo.position = CGPoint(x: self.frame.midX, y: self.frame.midY + frame.size.height/4)
        self.addChild(logo)
    }
    
    func addLabels () {
        let playLabel = SKLabelNode(text: "Tap to play", font: "AvenirNext-Bold", fontSize: 50.0, color: UIColor.white, position: CGPoint(x: frame.midX, y: frame.midY))
        
        addChild(playLabel)
        animate(label: playLabel)
        
        let highScoreLabel = SKLabelNode(text: "Highscore:" + "\(UserDefaults.standard.integer(forKey: "bestScore") )", font: "AvenirNext-Bold", fontSize: 40.0, color: UIColor.white, position: CGPoint(x: frame.midX, y: frame.midY))
        addChild(highScoreLabel)
        highScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - highScoreLabel.frame.size.height*4)
        
        let recentScoreLabel = SKLabelNode(text: "Recent Score:" + "\(UserDefaults.standard.integer(forKey: "recentScore") )", font: "AvenirNext-Bold", fontSize: 40.0, color: UIColor.white, position: CGPoint(x: frame.midX, y: frame.midY))
        recentScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - highScoreLabel.frame.size.height*2)
        
        addChild(recentScoreLabel)

    }
    
    func animate(label: SKLabelNode){
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        
        let sequence = SKAction.sequence([fadeOut, fadeIn])
        label.run(SKAction.repeatForever(sequence))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(size: view!.bounds.size)
        self.view?.presentScene(gameScene)
    }
}
