//
//  RushEnemy.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-02-18.
//

import Foundation
import GameplayKit

class RushEnemy: TestEnemy {
    
    var isCharging: Bool = false
    let chargeSpeedMultiplier: CGFloat = 3.0
    var chargeSpeed: CGFloat = 0.0
    
    var isStunned: Bool = false
    let stunDuration: CGFloat = 60 * 3
    var stunTick: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    override init(){
        super.init()
        name = "Rush Enemy"
        
        difficult = Enemy.easy
        
        chargeSpeed = enemySpeed * chargeSpeedMultiplier
        
        self.texture = SKTexture(imageNamed: "enemy_rush")
    }
    
    private func searchForPlayer() -> CGPoint {
        
        let worldWidth = (GameViewController.currentGameScene!.backgroundMap!.mapSize.width)
        //let worldWidth = (self.scene as! GameScene).backgroundMap!.mapSize.width
        let rayStart = self.position
        var targetBody = SKPhysicsBody()
        
        let directions = [CGPoint(x: 1, y: 0),//right
                          CGPoint(x: 0, y: -1),//down
                          CGPoint(x: -1, y: 0),//left
                          CGPoint(x: 0, y: 1)]//up
        
        var rays = [CGPoint]()
        
        let rayRight = CGPoint(x: self.position.x + worldWidth, y: self.position.y)
        rays.append(rayRight)
        let rayDown = CGPoint(x: self.position.x, y: self.position.y - worldWidth)
        rays.append(rayDown)
        let rayLeft = CGPoint(x: self.position.x - worldWidth, y: self.position.y)
        rays.append(rayLeft)
        let rayUp = CGPoint(x: self.position.x, y: self.position.y + worldWidth)
        rays.append(rayUp)
        
        var targets = [SKNode]()
        
        for i in 0..<rays.count {
            let rayEnd = rays[i]
            targetBody = GameViewController.currentGameScene!.physicsWorld.body(alongRayStart: rayStart, end: rayEnd)!
            if targetBody.node != nil {
                targets.append(targetBody.node!)
            }
        }
        
        for i in 0..<targets.count {
            let target = targets[i]
            if target is Player {
                return directions[i]
            }
        }
        
        //return default when no player was found
        return CGPoint(x: 0, y: 0)
    }
    
    private func knockBack() {
        
        if direction.x > 0 {
            position.x -= Enemy.knockbackMultiplier
        }
        else if direction.x < 0 {
            position.x += Enemy.knockbackMultiplier
        }
        else if direction.y > 0 {
            position.y -= Enemy.knockbackMultiplier
        }
        else if direction.y < 0 {
            position.y += Enemy.knockbackMultiplier
        }
        
        position = centerInCurrentTile()
        
    }
    
    private func applyStun() {
        
        let stunParticle = SKEmitterNode(fileNamed: "RushStun")
        stunParticle!.position = position
        stunParticle!.position.y += 16
        stunParticle!.zPosition = 100
        GameViewController.currentGameScene!.addChild(stunParticle!)
        GameViewController.currentGameScene!.run(SKAction.wait(forDuration: Double(stunDuration))) {
            stunParticle!.removeFromParent()
        }
        SoundManager.playSFX(SoundManager.rushImpactSFX)
    }
    
    override func collision(with other: SKNode?) {
        
        if !isCharging || other is TrapBomb {
            super.collision(with: other)
        }
        
        if !isStunned && isCharging && !(other is TrapBomb) {
            isStunned = true
        }
        
        isCharging = false
    }
    
    override func update() {
        
        updateZPosition()
        
        if trapPosition != nil {
            isCharging = false
            super.update()
            return
        }
        
        if isTrapped {
            return
        }
        
        if isStunned {
            if stunTick == 0 {
                knockBack()
                applyStun()
            }
            stunTick += 1
            if stunTick >= stunDuration {
                stunTick = 0
                isStunned = false
            }
            return
        }
            
        //different logic when charging
        if isCharging {
            position.x += (direction.x * chargeSpeed)
            position.y += (direction.y * chargeSpeed)
            
            return
        }
        
        //Normal update state
        
        super.update()
        
        let rushDirection = searchForPlayer()
        if rushDirection.x == 0 && rushDirection.y == 0 {
            //No player found in path
            return
        }
        else {
            isCharging = true
            direction = rushDirection
            
            position = centerInCurrentTile()
        }
        
        
            
        
    }
}
