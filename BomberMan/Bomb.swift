//
//  Bomb.swift
//  BomberMan
//
//  Created by Calle Höglund on 2022-02-16.
//

import Foundation
import SpriteKit

enum BombSettings{
    
    static var tickingTime: Float = 0
    static let explosionTime: Int = 3
    static let blastRadius: Int = 1
    
    
}

class Bomb: SKSpriteNode{
    
    static var bombs = [Enemy]()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(){
        let texture = SKTexture(imageNamed: "bugspray")
        super.init(texture: texture, color: .white, size: texture.size())
        name = "Bomb Object"
        zPosition = 50
    }
    
    func createPhysicsBody(tile: SKTileDefinition){
        
        physicsBody = SKPhysicsBody(rectangleOf: tile.size)
        physicsBody?.categoryBitMask = PhysicsCategory.Bomb
        physicsBody?.contactTestBitMask = PhysicsCategory.All
        physicsBody?.collisionBitMask = PhysicsCategory.All
        physicsBody?.restitution = 0
        physicsBody?.isDynamic = false
        physicsBody?.friction = 0
        physicsBody?.allowsRotation = false
    }
    
    
    
    
}
