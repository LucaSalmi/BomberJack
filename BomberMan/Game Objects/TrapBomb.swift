//
//  TrapBomb.swift
//  BomberMan
//
//  Created by Luca Salmi on 2022-02-22.
//

import Foundation
import SpriteKit

class TrapBomb: Bomb{
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init() {
        
        let texture = SKTexture(imageNamed: "bugspray")
        super.init(texture, .white, (GameScene.tileSize)!)
        name = "Bomb Object"
        zPosition = 50
    }
    
    override func update() {
        
        let scene = GameViewController.currentGameScene
        let distanceX = abs((scene?.player?.position.x)! - position.x)
        let distanceY = abs((scene?.player?.position.y)! - position.y)
        
        if distanceX >= GameScene.tileSize!.width || distanceY >= GameScene.tileSize!.height{
            
            physicsBody?.categoryBitMask = PhysicsCategory.Bomb
        }
        
        tickingTime += 1
        
        if tickingTime >= BombSettings.explosionTime {
            for i in 0..<Bomb.bombs.count {
                if i >= Bomb.bombs.count {return}
                let bomb = Bomb.bombs[i]
                if bomb == self{
                    removeFromParent()
                    Bomb.bombs.remove(at: i)
                    explosion(position)
                    
                }
            }
        }
    }
}
