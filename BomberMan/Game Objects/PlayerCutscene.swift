//
//  PlayerCutscene.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-03-09.
//

import Foundation
import GameplayKit

class PlayerCutscene: SKSpriteNode {
    
    let floatLimit: CGFloat = 5
    let floatAmount: CGFloat = 0.2
    var currentFloatY: CGFloat = 0
    var floatUp: Bool = true
    
    let speedX: CGFloat = 1
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(){
        let texture = SKTexture(imageNamed: "player_floating")
        var size: CGSize = GameScene.tileSize!
        size.width += PlayerSettings.textureOffset
        let tempColor = UIColor(red: 100, green: 100, blue: 100, alpha: 0)
        super.init(texture: texture, color: tempColor, size: size)
        name = "Player"
        zPosition = 99

    }
    
    private func removeSelf() {
        GameViewController.currentGameScene!.player!.showPlayer()
    }
    
    func update() {
        
        switch UserData.currentLevel {
        case 1:
            
            if floatUp {
                currentFloatY += floatAmount
                position.y += floatAmount
            }
            else {
                currentFloatY -= floatAmount
                position.y -= floatAmount
            }
            
            if currentFloatY >= floatLimit {
                floatUp = false
            }
            if currentFloatY <= -floatLimit {
                floatUp = true
            }
            
            self.position.x += speedX
            
            if self.position.x >= GameViewController.currentGameScene!.player!.position.x {
                let gameScene = GameViewController.currentGameScene!
                
                //Unique logarithm for this event goes here
                let level1IntroDialogue = Level1IntroDialogue()
                gameScene.currentDialogue = level1IntroDialogue
                gameScene.addChild(level1IntroDialogue)
                removeSelf()
            }
        default:
            removeSelf()
        }
        
        
        
    }
    
}
