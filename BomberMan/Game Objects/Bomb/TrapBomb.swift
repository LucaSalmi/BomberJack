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
        
        let texture = SKTexture(imageNamed: "trap_bomb_flat")
        super.init(texture, .white, (GameScene.tileSize)!)
        name = "Trap Object"
        zPosition = 40
    }
    
    
    override func createPhysicsBody() {
        
        physicsBody = SKPhysicsBody(circleOfRadius: (size.width/2) * PhysicsUtils.physicsBodyPct)
        physicsBody?.categoryBitMask = PhysicsCategory.InactiveBomb
        physicsBody?.collisionBitMask = PhysicsCategory.Player | PhysicsCategory.Enemy
        physicsBody?.contactTestBitMask = PhysicsCategory.Player | PhysicsCategory.Enemy
        physicsBody?.isDynamic = false
        
        
    }
    
    override func update() {
        
        let scene = GameViewController.currentGameScene
        let distanceX = abs((scene?.player?.position.x)! - position.x)
        let distanceY = abs((scene?.player?.position.y)! - position.y)
        
        if distanceX >= GameScene.tileSize!.width || distanceY >= GameScene.tileSize!.height{
            
            physicsBody?.categoryBitMask = PhysicsCategory.TrapBomb
        }
        
        for i in 0..<Bomb.bombs.count {
            if i >= Bomb.bombs.count {return}
            let bomb = Bomb.bombs[i]
            
            if bomb == self && self.isTrapActive{
                
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
