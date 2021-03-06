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
        
        let texture = SKTexture(imageNamed: "bomb")
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
    
    
    override func activation(_ position: CGPoint){
        
     
        let explosion0 = Explosion(position: position, explosionAnimPart: ExplosionPosition.center.rawValue)
        explosion0.texture = SKTexture(imageNamed: "start explosion middle 5")
        ExplosionSettings.explosionsArray.append(explosion0)
        
        let explosion1 = Explosion(position: position, explosionAnimPart: ExplosionPosition.left.rawValue)
        explosion1.position.x += ExplosionSettings.distanceNeg
        explosion1.texture = SKTexture(imageNamed: "start explosion left 5")
        ExplosionSettings.explosionsArray.append(explosion1)
        
        let explosion2 = Explosion(position: position, explosionAnimPart: ExplosionPosition.right.rawValue)
        explosion2.position.x += ExplosionSettings.distancePos
        explosion2.texture = SKTexture(imageNamed: "start explosion right 5")
        ExplosionSettings.explosionsArray.append(explosion2)
        
        let explosion3 = Explosion(position: position, explosionAnimPart: ExplosionPosition.bottom.rawValue)
        explosion3.position.y += ExplosionSettings.distanceNeg
        explosion3.texture = SKTexture(imageNamed: "start explosion bottom 5")
        ExplosionSettings.explosionsArray.append(explosion3)
        
        let explosion4 = Explosion(position: position, explosionAnimPart: ExplosionPosition.top.rawValue)
        explosion4.position.y += ExplosionSettings.distancePos
        explosion4.texture = SKTexture(imageNamed: "start explosion top 5")
        ExplosionSettings.explosionsArray.append(explosion4)
    
        let scene = GameViewController.currentGameScene
        for explosion in ExplosionSettings.explosionsArray{
            if explosion.parent == nil {
                explosion.zPosition = self.zPosition
                scene?.explosionsNode!.addChild(explosion)
            }
        }
            
        SoundManager.playSFX(SoundManager.explosionSFX)
        
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
                    activation(position)
                    
                }
            }
        }
    }
}
