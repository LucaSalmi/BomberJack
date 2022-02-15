//
//  TestEnemy.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-02-15.
//

import Foundation
import GameplayKit

class TestEnemy: Enemy {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(){
        let texture = SKTexture(imageNamed: "bug_ft1")
        super.init(texture: texture, color: .white, size: texture.size())
        name = "Test Enemy"
        zPosition = 40
        
        physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        physicsBody?.categoryBitMask = PhysicsCategory.Enemy
        physicsBody?.contactTestBitMask = PhysicsCategory.Enemy
        physicsBody?.restitution = 0
        physicsBody?.allowsRotation = false
        
        enemySpeed = 1.0
        
    }
    
    override func update() {
        
        position.x += enemySpeed
        
    }
    
}
