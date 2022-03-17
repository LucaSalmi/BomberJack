//
//  RushEnemy.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-02-18.
//

import Foundation
import GameplayKit

class RushEnemy: Enemy {
    
    //Charge AI logic variables
    var isCharging: Bool = false
    let chargeSpeedMultiplier: CGFloat = 3.5
    var chargeSpeed: CGFloat = 0.0
    
    //Movement AI logic variables
    var changeDirectionInterval: CGFloat = 0.0
    let tileSize: CGFloat = 32.0  //32 = tile size
    let minIntervalMultiplier: Int = 1
    let maxIntervalMultiplier: Int = 5
    var currentMovementDistance: CGFloat = 0.0
    var direction = CGPoint(x: 0, y: 0)
    
    var isStunned: Bool = false
    let stunDuration: CGFloat = 60 * 3
    var stunTick: CGFloat = 0
    
    let characterAnimationNames = ["rush_right_", "rush_left_", "rush_down_", "rush_top_"]
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(){
        
        let size: CGSize = CGSize(width: 32, height: 32)
        let tempColor = UIColor(red: 100, green: 100, blue: 100, alpha: 0)
        super.init(SKTexture(imageNamed: "player_shadow"), tempColor, size)
        name = "Rush Enemy"
        
        difficult = Enemy.easy
        enemySpeed = 0.5
        chargeSpeed = enemySpeed * chargeSpeedMultiplier
        self.enemyTexture.texture = SKTexture(imageNamed: "rush_down_1")
        setRushEnemyAnimations(characterAnimationNames: characterAnimationNames)
        direction = getRandomDirection()
    }
    
    internal func getRandomDirection() -> CGPoint {
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
        
        //set random move distance based on tile size and a random multiplier within limits
        let intervalMultiplier: Int = Int.random(in: minIntervalMultiplier...maxIntervalMultiplier)
        changeDirectionInterval = tileSize * CGFloat(intervalMultiplier)
        currentMovementDistance = 0 //reset move distance after changing direction
        
        return newDirection
    }
    
    private func updateDirection(newDirection: CGPoint) {
        
        self.position = centerInCurrentTile()
        
        direction = newDirection
    }
    
    private func searchForPlayer() -> CGPoint {
        
        let cancelSearch = CGPoint(x: 0, y: 0)
        
        guard let backgroundMap = GameViewController.currentGameScene!.childNode(withName: "background")as? SKTileMapNode else {
            return cancelSearch
        }
        
        let worldWidth = (GameViewController.currentGameScene!.backgroundMap!.mapSize.width)
        //let worldWidth = (self.scene as! GameScene).backgroundMap!.mapSize.width
        guard let rayStart = PhysicsUtils.findCenterOfClosestTile(map: backgroundMap, object: self) else { return cancelSearch }
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
        return cancelSearch
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
        
        if other is Player {
            if !GameViewController.currentGameScene!.player!.isShielded {
                SoundManager.playSFX(SoundManager.bloodSplatterSFX)
            }
        }
        
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
            normalUpdate()
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
            
            enemyTexture.position.x = position.x
            enemyTexture.position.y = position.y + PlayerSettings.textureOffset
            
            //for Animations
            let direction = PhysicsUtils.findDirection(objDirection: direction)
            runAnim(objDirection: direction)
            
            return
        }
        
        //Normal update state
        super.update()
        normalUpdate()

        
        let rushDirection = searchForPlayer()
        if rushDirection.x == 0 && rushDirection.y == 0 {
            //No player found in path
            return
        }
        else {
            isCharging = true
            direction = rushDirection
            
            position = centerInCurrentTile()
            
            SoundManager.playSFX(SoundManager.rushStartSFX)
        }
    }
    
    func normalUpdate(){
        
        position.x += (direction.x * enemySpeed)
        position.y += (direction.y * enemySpeed)
        
        currentMovementDistance += enemySpeed
        if currentMovementDistance == changeDirectionInterval {
            updateDirection(newDirection: getRandomDirection())
        }
        
        enemyTexture.position.x = position.x
        enemyTexture.position.y = position.y + PlayerSettings.textureOffset
        
        let animationDirection = PhysicsUtils.findDirection(objDirection: direction)
        runAnim(objDirection: animationDirection)
        
    }
    
    
    
}
