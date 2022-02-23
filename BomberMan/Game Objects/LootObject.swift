//
//  LootObject.swift
//  BomberMan
//
//  Created by Hampus Brandtman on 2022-02-22.
//

import Foundation
import GameplayKit

class LootObject: SKSpriteNode {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(_ texture: SKTexture, _ color: UIColor, _ size: CGSize){
        
        super.init(texture: texture, color: color, size: size)
        print("loot initilized")
        createPhysicsBody()
    }
    func createPhysicsBody(){
        
        physicsBody = SKPhysicsBody(circleOfRadius: (size.width/2) * PhysicsUtils.physicsBodyPct)
        physicsBody?.categoryBitMask = PhysicsCategory.Loot
        physicsBody?.contactTestBitMask = PhysicsCategory.Player
        physicsBody?.collisionBitMask = PhysicsCategory.Player
        physicsBody?.isDynamic = false
        
    }
    func collision(loot: SKNode?) {
        print("loot collision")
        //Override this in enemy subclasses
        loot?.removeFromParent()
        
    }
    
}


