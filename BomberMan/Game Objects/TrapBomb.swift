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
    
    
    override func activation(_ position: CGPoint) {
         
        self.isTrapActive = true
        physicsBody = SKPhysicsBody(circleOfRadius: (size.width/2) * PhysicsUtils.physicsBodyPct)
        physicsBody?.categoryBitMask = PhysicsCategory.TrapBomb
        physicsBody?.collisionBitMask = PhysicsCategory.Player | PhysicsCategory.Enemy
        physicsBody?.contactTestBitMask = PhysicsCategory.Player | PhysicsCategory.Enemy
        physicsBody?.isDynamic = false
        
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
                        resetBools()
                        Bomb.bombs.remove(at: i)
                        bomb.removeFromParent()
                    }

                }
            }
        }
    }
    
    func resetBools(){
        
        let scene = GameViewController.currentGameScene
        scene?.player?.isTrapped = false
        for enemy in Enemy.enemies{
            if enemy.isTrapped{
                enemy.isTrapped = false
            }
        }
        
    }
}
