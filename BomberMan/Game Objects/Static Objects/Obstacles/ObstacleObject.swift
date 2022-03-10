//
//  ObstacleObject.swift
//  BomberMan
//
//  Created by Luca Salmi, Daniel Falkedal, Calle Höglund, Hampus Brandtman on 2022-02-16.
//

import Foundation
import SpriteKit

class ObstacleObject: SKSpriteNode{
    
    var obstacleTexture: SKSpriteNode
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(textureName: String){
        
        //Texture Init
            
        let objTexture = SKTexture(imageNamed: textureName)
        
        var size = GameScene.tileSize
        size?.height += BreakableSettings.sizeOffset
        //size?.width += 8 // temporary
        if textureName != "barricade"{
            
            obstacleTexture = SKSpriteNode(texture: objTexture, color: .clear, size: size!)
            
        }else{
            
            obstacleTexture = SKSpriteNode(texture: nil, color: .clear, size: size!)
        }
        
        
        super.init(texture: nil, color: .clear, size: GameScene.tileSize!)
        name = "Obstacle Object"
        zPosition = 50
    }
    
    func createPhysicsBody(tile: SKTileDefinition){
        
        physicsBody = SKPhysicsBody(circleOfRadius: (tile.size.width/2) * PhysicsUtils.physicsBodyPct)
        physicsBody?.categoryBitMask = PhysicsCategory.Obstacle
        physicsBody?.collisionBitMask = 0
        physicsBody?.restitution = 0
        physicsBody?.isDynamic = true
        physicsBody?.friction = 0
        physicsBody?.allowsRotation = false
        
        lightingBitMask = 1
    }
    
    func collision(with other: SKNode?) {
        
       print("hihi")
        
    }
}
