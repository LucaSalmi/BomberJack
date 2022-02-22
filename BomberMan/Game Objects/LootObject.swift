//
//  LootObject.swift
//  BomberMan
//
//  Created by Hampus Brandtman on 2022-02-22.
//

import Foundation
import GameplayKit

class lootObject: SKSpriteNode {
    
    var keyTexture: SKSpriteNode! = SKSpriteNode()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(_ texture: SKTexture, _ color: UIColor, _ size: CGSize){
        
        super.init(texture: texture, color: color, size: size)
        createPhysicsBody()
    }
    func createPhysicsBody(){
        
        physicsBody = SKPhysicsBody(circleOfRadius: (size.width/2) * PhysicsUtils.physicsBodyPct)
        physicsBody?.categoryBitMask = PhysicsCategory.Loot
        physicsBody?.collisionBitMask = PhysicsCategory.Player
        physicsBody?.isDynamic = true
        physicsBody?.restitution = 0
        physicsBody?.friction = 0
        physicsBody?.allowsRotation = false
        
    }
    
    }


