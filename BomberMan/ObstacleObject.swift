//
//  ObstacleObject.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-02-16.
//

import Foundation
import SpriteKit

class ObstacleObject: SKSpriteNode{
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(){
        let texture = SKTexture(imageNamed: "wall")
        super.init(texture: texture, color: .white, size: texture.size())
        name = "Obstacle Object"
        zPosition = 50
    }
    
    func createPhysicsBody(tile: SKTileDefinition){
        
        physicsBody = SKPhysicsBody(rectangleOf: tile.size)
        physicsBody?.categoryBitMask = PhysicsCategory.Obstacle
        physicsBody?.restitution = 0
        physicsBody?.isDynamic = false
        physicsBody?.friction = 0
        physicsBody?.allowsRotation = false
    }
    
    func collision(with other: SKNode?) {
        
       
        
    }
}
