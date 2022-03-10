//
//  Door.swift
//  BomberMan
//
//  Created by Calle Höglund on 2022-02-24.
//

import Foundation
import SpriteKit

class Door: SKSpriteNode{
    
    var doorTexture: SKSpriteNode
    var isOpened: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(textureName: String){
        
        //Texture init
        let objTexture = SKTexture(imageNamed: textureName)
        var size = GameScene.tileSize
        size?.height += BreakableSettings.sizeOffset
        doorTexture = SKSpriteNode(texture: objTexture, color: .clear, size: size!)
        
        super.init(texture: nil, color: .clear, size: GameScene.tileSize!)
        
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
        
        if PlayerSettingsUI.instance.amountOfKeys > 0{
            PlayerSettingsUI.instance.amountOfKeys -= 1
            other?.physicsBody = nil
            self.isOpened = true
            SoundManager.playSFX("doorsound")
            
            
        }
        
        
        
       
        
        
    }
    
}
