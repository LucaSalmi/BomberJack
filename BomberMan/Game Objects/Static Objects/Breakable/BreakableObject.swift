//
//  BreakableObject.swift
//  BomberMan
//
//  Created by Luca Salmi, Daniel Falkedal, Calle Höglund, Hampus Brandtman on 2022-02-15.
//

import Foundation
import SpriteKit

enum BreakableSettings{
    
    static let sizeOffset: CGFloat = 25
    
}

class BreakableObject: SKSpriteNode{
    
    var breakableTexture: SKSpriteNode
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(textureName: String, yOffset: CGFloat){
        
        //Texture Init
        let objTexture = SKTexture(imageNamed: textureName)
        var size = GameScene.tileSize
        size?.height += yOffset
        size?.width += 8 // temporary
        breakableTexture = SKSpriteNode(texture: objTexture, color: .clear, size: size!)
        breakableTexture.lightingBitMask = 1
        
        super.init(texture: nil, color: .clear, size: GameScene.tileSize!)
        zPosition = 50

    }
    
    func createPhysicsBody(tile: SKTileDefinition){
        
        physicsBody = SKPhysicsBody(circleOfRadius: (tile.size.width/2) * PhysicsUtils.physicsBodyPct)
        physicsBody?.categoryBitMask = PhysicsCategory.Breakable
        physicsBody?.collisionBitMask = 0
        physicsBody?.isDynamic = true
        
        lightingBitMask = 1
    }
    
    func collision(breakable: SKNode?) {
        
        breakable?.removeFromParent()
        breakable?.physicsBody = nil
        
    }
}
