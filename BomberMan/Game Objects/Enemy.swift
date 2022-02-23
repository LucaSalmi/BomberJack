//
//  Enemy.swift
//  BomberMan
//
//  Created by Luca Salmi, Daniel Falkedal, Calle Höglund, Hampus Brandtman on 2022-02-15.
//

import Foundation
import GameplayKit

class Enemy: SKSpriteNode {
    
    //Keep references to all enemies
    static var enemies = [Enemy]()

    //Constants (replace with enum)
    static let superEasy: Int = 0
    static let easy: Int = 1
    static let normal: Int = 2
    static let hard: Int = 3
    static let superHard: Int = 4
    
    //change these variables in enemy subclass
    var enemySpeed: CGFloat = 0.0
    var difficult: Int = 0
    var isAlive: Bool = true
    
    //trap Boolean
    var isTrapped = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(_ texture: SKTexture, _ color: UIColor, _ size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        physicsBody = SKPhysicsBody(circleOfRadius: (size.width/2) * PhysicsUtils.physicsBodyPct)
        physicsBody?.categoryBitMask = PhysicsCategory.Enemy
        physicsBody?.contactTestBitMask = PhysicsCategory.All
        physicsBody?.collisionBitMask = PhysicsCategory.Obstacle | PhysicsCategory.Breakable | PhysicsCategory.Bomb | PhysicsCategory.InactiveBomb | PhysicsCategory.TrapBomb
        physicsBody?.restitution = 0
        physicsBody?.allowsRotation = false
        
        zPosition = 50
    }
    
    func bloodParticle() {
        let bloodParticle = SKEmitterNode(fileNamed: "BloodSplatter")
        bloodParticle!.position = position
        bloodParticle!.zPosition = 100
        GameViewController.currentGameScene!.addChild(bloodParticle!)
        GameViewController.currentGameScene!.run(SKAction.wait(forDuration: 1)) {
            bloodParticle!.removeFromParent()
        }
        SoundManager.playSFX(SoundManager.bloodSplatterSFX)
    }
    
    func deathParticle() {
        let deathParticle = SKEmitterNode(fileNamed: "EnemyDeath")
        deathParticle!.particleTexture = texture
        deathParticle!.position = position
        deathParticle!.zPosition = 100
        GameViewController.currentGameScene!.addChild(deathParticle!)
        GameViewController.currentGameScene!.run(SKAction.wait(forDuration: 1)) {
            deathParticle!.removeFromParent()
        }
        //Play sound SFX on death?
    }
    
    func collision(with other: SKNode?) {
        //Override this in enemy subclasses
        
        if other is Explosion {
            for i in 0..<Enemy.enemies.count {
                if i >= Enemy.enemies.count {
                    return
                }
                let enemy = Enemy.enemies[i]
                if enemy == self {
                    
                    //stat change
                    UserData.enemiesKilled += 1
                    isAlive = false
                }
            }
        }
        
        if other is TrapBomb{
            
            for i in 0..<Enemy.enemies.count {
                if i >= Enemy.enemies.count {
                    return
                }
                let enemy = Enemy.enemies[i]
                if enemy == self {
                    if !isTrapped {
                        bloodParticle()
                    }
                    isTrapped = true
                }
            }
        }
        
    }
 
    func update() {
        //Override this in enemy subclasses
    }
    
}
