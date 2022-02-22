//
//  StandardBomb.swift
//  BomberMan
//
//  Created by Luca Salmi on 2022-02-22.
//

import Foundation
import SpriteKit

class StandardBomb: Bomb{
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init() {
        
        let texture = SKTexture(imageNamed: "bomb1")
        super.init(texture, .white, (GameScene.tileSize)!)
        name = "Bomb Object"
        zPosition = 50
    }
    
    
    func explosion(_ position: CGPoint){
        
     
        let explosion0 = Explosion(position: position)
        ExplosionSettings.explosionsArray.append(explosion0)
        
        let explosion1 = Explosion(position: position)
        explosion1.position.x += ExplosionSettings.distanceNeg
        ExplosionSettings.explosionsArray.append(explosion1)
        
        let explosion2 = Explosion(position: position)
        explosion2.position.x += ExplosionSettings.distancePos
        ExplosionSettings.explosionsArray.append(explosion2)
        
        let explosion3 = Explosion(position: position)
        explosion3.position.y += ExplosionSettings.distanceNeg
        ExplosionSettings.explosionsArray.append(explosion3)
        
        let explosion4 = Explosion(position: position)
        explosion4.position.y += ExplosionSettings.distancePos
        ExplosionSettings.explosionsArray.append(explosion4)
    
        let scene = GameViewController.currentGameScene
        for explosion in ExplosionSettings.explosionsArray{
            if explosion.parent == nil {
                scene?.explosionsNode!.addChild(explosion)
            }
        }
            
        if scene != nil {
            SoundManager.playSFX(SoundManager.explosionSFX, scene!)
        }
        
        PhysicsUtils.shakeCamera(duration: CGFloat(0.5))
        
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
