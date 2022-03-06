//
//  Door.swift
//  BomberMan
//
//  Created by Calle Höglund on 2022-02-24.
//

import Foundation
import SpriteKit

class Door: SKSpriteNode{
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(texture: SKTexture){
        
        super.init(texture: texture, color: .white, size: GameScene.tileSize!)
        
        name = "Door Object"
        zPosition = 50
        createPhysicsBody()
    }
    
    func createPhysicsBody(){
        
        physicsBody = SKPhysicsBody(circleOfRadius: (size.width/2) * PhysicsUtils.physicsBodyPct)
        physicsBody?.categoryBitMask = PhysicsCategory.Door
    
        physicsBody?.contactTestBitMask = PhysicsCategory.Player
        physicsBody?.collisionBitMask = PhysicsCategory.Player
        physicsBody?.isDynamic = false
            
    }
    
    func collision(with other: SKNode?) {
        
        if PlayerSettings.amountOfKeys > 0{
            PlayerSettings.amountOfKeys -= 1
            other?.physicsBody = nil
            SoundManager.playSFX("doorsound")
            
            
        }
        
        
        
       
        
        
    }
    
}
