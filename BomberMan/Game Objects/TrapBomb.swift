//
//  TrapBomb.swift
//  BomberMan
//
//  Created by Luca Salmi on 2022-02-22.
//

import Foundation
import SpriteKit

class TrapBomb: Bomb{
    
    var trapActive: Int = 0
    var activeTraps: [TrapBomb] = []
    var isTrapActive = false
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init() {
        
        let texture = SKTexture(imageNamed: "bugspray")
        super.init(texture, .white, (GameScene.tileSize)!)
        name = "Bomb Object"
        zPosition = 50
    }
    
    override func createPhysicsBody() {
        
        physicsBody = SKPhysicsBody(circleOfRadius: (size.width/2) * PhysicsUtils.physicsBodyPct)
        physicsBody?.categoryBitMask = PhysicsCategory.InactiveBomb
        physicsBody?.collisionBitMask = 0
        physicsBody?.isDynamic = true
        physicsBody?.restitution = 0
        physicsBody?.friction = 0
        physicsBody?.allowsRotation = false
    }
    
    override func activation(_ position: CGPoint) {
         
        self.isTrapActive = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.TrapBomb
    }
    
    override func update() {
        
        tickingTime += 1
        
        if tickingTime >= BombSettings.activateTrap {
            for i in 0..<Bomb.bombs.count {
                if i >= Bomb.bombs.count {return}
                let bomb = Bomb.bombs[i]
                if bomb == self && !self.isTrapActive{
                                        
                    activation(position)
                    print("trap active")
                    
                }else if bomb == self && self.isTrapActive{
                    
                    trapActive += 1
                    
                    if trapActive >= BombSettings.trapDuration{
                        
                        print("trap removed")
                        Bomb.bombs.remove(at: i)
                        bomb.removeFromParent()
                    }

                }
            }
        }
    }
}
