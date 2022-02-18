//
//  Explosion.swift
//  BomberMan
//
//  Created by Luca Salmi on 2022-02-18.
//

import Foundation
import SpriteKit

enum ExplosionSettings{
    
    static var range: Int = 1
    static var size: Int = 5
    static var distancePos: CGFloat = 32
    static var distanceNeg: CGFloat = -32
    static var permanence: Int = 60
    static var explosionsArray: [Explosion] = []
    static var explosionId: Int = 0
}

class Explosion: SKSpriteNode{
    
    var count: Int = 0
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(position: CGPoint){
        
        let texture = SKTexture(imageNamed: "explosion1")
        let size: CGSize = GameScene.tileSize ?? CGSize(width: 32, height: 32)
        super.init(texture: texture, color: .white, size: size)
        self.position = position
        zPosition = 60
        name = "Explosion\(ExplosionSettings.explosionId)"
        ExplosionSettings.explosionId += 1
        createPhysicsBody()
    }
    
    func createPhysicsBody(){
        
        physicsBody = SKPhysicsBody(rectangleOf: GameScene.tileSize ?? CGSize(width: 32, height: 32))
        physicsBody?.categoryBitMask = PhysicsCategory.Explosion
        physicsBody?.collisionBitMask = PhysicsCategory.Breakable
        physicsBody?.restitution = 0
        physicsBody?.isDynamic = false
        physicsBody?.friction = 0
        physicsBody?.allowsRotation = false
    }
    
    func update(){
       
        count += 1
        
        if count >= ExplosionSettings.permanence{
            
            count = 0
            self.removeFromParent()
            ExplosionSettings.explosionsArray.remove(at: ExplosionSettings.explosionsArray.firstIndex(of: self)!)
        }
        
    }
}
