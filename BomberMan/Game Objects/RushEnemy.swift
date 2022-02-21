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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    override init(){
        super.init()
        name = "Rush Enemy"
        
        difficult = Enemy.easy
        
        chargeSpeed = enemySpeed * chargeSpeedMultiplier
        
        self.texture = SKTexture(imageNamed: "firebug")
    }
    
    private func searchForPlayer() -> CGPoint {
        
        let worldWidth = (self.scene as! GameScene).backgroundMap!.mapSize.width
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
            targetBody = self.scene!.physicsWorld.body(alongRayStart: rayStart, end: rayEnd)!
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
    
    override func collision(with other: SKNode?) {
        isCharging = false
    }
    
    override func update() {
        
        //base logic is same as parent Test Enemy
        if !isCharging {
            super.update()
            
            let rushDirection = searchForPlayer()
            if rushDirection.x == 0 && rushDirection.y == 0 {
                //No player found in path
                return
            }
            else {
                isCharging = true
                direction = rushDirection
                
                guard let backgroundMap = scene!.childNode(withName: "background")as? SKTileMapNode else {
                    return
                }
                let center = PhysicsUtils.findCenterOfClosestTile(map: backgroundMap, object: self)
                if center != nil {
                    self.position = center!
                }
            }
        }
        
        //different logic when charging
        
        
        position.x += (direction.x * chargeSpeed)
        position.y += (direction.y * chargeSpeed)
        
        
        
    }
    
}
