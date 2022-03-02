//
//  BreakableObject.swift
//  BomberMan
//
//  Created by Luca Salmi, Daniel Falkedal, Calle Höglund, Hampus Brandtman on 2022-02-15.
//

import Foundation
import SpriteKit

class BreakableObject: SKSpriteNode{
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(){
        
        let texture = SKTexture(imageNamed: "tree")
        super.init(texture: texture, color: .white, size: texture.size())
        name = "Breakable Object"
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
