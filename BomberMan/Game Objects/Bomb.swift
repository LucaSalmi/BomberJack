//
//  Bomb.swift
//  BomberMan
//
//  Created by Calle Höglund on 2022-02-16.
//

import Foundation
import SpriteKit

enum BombSettings{
    
    static var tickingTime: Float = 0
    static let explosionTime: Int = 3
    static let blastRadius: Int = 1
    
    
}

class Bomb: SKSpriteNode{
    
    static var bombs = [Enemy]()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(){
        let texture = SKTexture(imageNamed: "bugspray")
        super.init(texture: texture, color: .white, size: texture.size())
        name = "Bomb Object"
        zPosition = 50
    }
    
    func createPhysicsBody(tile: SKTileDefinition){
        
        physicsBody = SKPhysicsBody(rectangleOf: tile.size)
        physicsBody?.categoryBitMask = PhysicsCategory.Bomb
        physicsBody?.contactTestBitMask = PhysicsCategory.All
        physicsBody?.collisionBitMask = PhysicsCategory.All
        physicsBody?.restitution = 0
        physicsBody?.isDynamic = false
        physicsBody?.friction = 0
        physicsBody?.allowsRotation = false
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
        for i in ExplosionSettings.explosionsArray{
            scene?.explosionsNode!.addChild(i)
        }
            
        
        PhysicsUtils.shakeCamera(duration: CGFloat(0.5))
        
    }
    
    
}
