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
    static var attacks = [SwordAttack]()

    //Constants (replace with enum)
    static let superEasy: Int = 0
    static let easy: Int = 1
    static let normal: Int = 2
    static let hard: Int = 3
    static let superHard: Int = 4
    
    static let knockbackMultiplier = 16.0
    
    //Animation Variables
    var rightAnimations: [SKAction] = []
    var leftAnimations: [SKAction] = []
    var upAnimations: [SKAction] = []
    var downAnimations: [SKAction] = []
    var corpseTexture = SKSpriteNode(texture: SKTexture(imageNamed: "corpse_with_flesh"), size: GameScene.tileSize!)
    
    //change these variables in enemy subclass
    var enemySpeed: CGFloat = 0.0
    var difficult: Int = 0
    var isAlive: Bool = true
    
    //trap Boolean
    var isTrapped = false
    var trapPosition: CGPoint?
    
    
    
    var enemyTexture: SKSpriteNode = SKSpriteNode()
    
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
        
        
        //init() for texture
        let textureSize = CGSize(width: size.width, height: size.height*1.5)
        enemyTexture = SKSpriteNode(texture: texture, color: UIColor(red: 0, green: 0, blue: 0, alpha: 0), size: textureSize)
        enemyTexture.position = position
        enemyTexture.zPosition = 50
        enemyTexture.lightingBitMask = 1
        
        corpseTexture.lightingBitMask = 1
        
        setEnemyAnimations(enemy: "enemy_walk_animation")
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
        deathParticle!.particleTexture = enemyTexture.texture
        deathParticle!.position = position
        deathParticle!.zPosition = 100
        GameViewController.currentGameScene!.addChild(deathParticle!)
        GameViewController.currentGameScene!.run(SKAction.wait(forDuration: 1)) {
            deathParticle!.removeFromParent()
        }
        //Play sound SFX on death?
    }
    
    func centerInCurrentTile() -> CGPoint {
        guard let backgroundMap = GameViewController.currentGameScene!.childNode(withName: "background")as? SKTileMapNode else {
            return self.position
        }
        let center = PhysicsUtils.findCenterOfClosestTile(map: backgroundMap, object: self)
        if center != nil {
            return center!
        }
        return self.position
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
                    spawnCorpse()
                    isAlive = false
                }
            }
        }
        
        if other is TrapBomb{
            
            let trap = other as! TrapBomb
            trap.isTrapActive = true
            trap.physicsBody = nil
            trapPosition = trap.position
            isTrapped = true
            
        }
        
    }
 
    private func spawnCorpse(){
        
        corpseTexture.position = self.position
        corpseTexture.zPosition = -99
        GameViewController.currentGameScene?.addChild(corpseTexture)
        
    }
    
    func update() {
        
        updateZPosition()
        
        if trapPosition != nil {
            position = trapPosition!
            bloodParticle()
            trapPosition = nil
            
            enemyTexture.position.x = position.x
            enemyTexture.position.y = position.y + PlayerSettings.textureOffset
        }
        
    }
    
    func updateZPosition() {
        GameScene.updateZPosition(object: self)
        enemyTexture.zPosition = self.zPosition
    }
    
    func runAnim(objDirection: Direction){
        
        switch objDirection {
            
        case .forward:
            enemyTexture.run(upAnimations[0], withKey: "animation")
        case .backward:
            enemyTexture.run(downAnimations[0], withKey: "animation")
        case .left:
            enemyTexture.run(leftAnimations[0], withKey: "animation")
        case .right:
            enemyTexture.run(rightAnimations[0], withKey: "animation")
        }
    }
    
    
}

extension Enemy: Animatable{}
