//
//  TestEnemy.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-02-15.
//

import Foundation
import GameplayKit

class TestEnemy: Enemy {
    
    //Movement AI logic variables
    let changeDirectionInterval: Int = 32
    var currentMovementDistance: Int = 0
    var direction = CGPoint(x: 0, y: 0)
    
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
        direction = getRandomDirection()
        
    }
    
    override func update() {
        
        position.x += (direction.x * enemySpeed)
        position.y += (direction.y * enemySpeed)
        
        currentMovementDistance += 1
        if currentMovementDistance == changeDirectionInterval {
            currentMovementDistance = 0
            direction = getRandomDirection()
        }
        
    }
    
    private func getRandomDirection() -> CGPoint {
        var newDirection = CGPoint(x: 0, y: 0)
        
        let moveSideways: Bool = Bool.random()
        if moveSideways {
            newDirection.x = 1
        }
        else {
            newDirection.y = 1
        }
        
        let invertDirection: Bool = Bool.random()
        if invertDirection {
            newDirection.x *= -1
            newDirection.y *= -1
        }
        
        return newDirection
    }
    
}
