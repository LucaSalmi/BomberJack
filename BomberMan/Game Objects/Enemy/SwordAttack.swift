//
//  SwordAttack.swift
//  BomberMan
//
//  Created by Luca Salmi on 2022-03-10.
//

import Foundation
import SpriteKit

class SwordAttack: SKSpriteNode{
    
    var swordCount = 0
    let tileSize: CGFloat = 32.0
    let physicsBodyPct = CGFloat(0.50)
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(){
        
        //declaring all necessary variables
        
        let swordTexture = SKTexture(imageNamed: "sword_swing_left_side")
        let swordSize = CGSize(width: tileSize, height: tileSize)
        //create sprite node for sword attack
        super.init(texture: swordTexture, color: .clear, size: swordSize)
        //setup physics body
        physicsBody = SKPhysicsBody(circleOfRadius: (size.width/4) * physicsBodyPct)
        physicsBody?.categoryBitMask = PhysicsCategory.Sword
        physicsBody?.collisionBitMask = PhysicsCategory.All
        physicsBody?.contactTestBitMask = PhysicsCategory.All
        physicsBody?.restitution = 0
        physicsBody?.isDynamic = false
        physicsBody?.friction = 0
        physicsBody?.allowsRotation = false

        Enemy.attacks.append(self)
    }
    
    func setPositions(with other: SKNode){
        
        let player = other as! Player
        let posY: CGFloat = CGFloat(player.position.y - tileSize)
        let swordPos = CGPoint(x: player.position.x, y: posY)
        position = swordPos
        zPosition = 50
        
    }
    
    func update(){
        
        if swordCount < 5{
            position.y += 1
            swordCount += 1
        }else if swordCount < 10{
            position.y += 2
            swordCount += 1
        }else if swordCount < 15{
            position.y += 3
            swordCount += 1
        }else{
            self.physicsBody = nil
            self.removeFromParent()
            guard let toRemove = Enemy.attacks.firstIndex(of: self) else { return }
            Enemy.attacks.remove(at: toRemove)
        }
        
        
        
        
//        switch swordCount{
//
//        case 0:
//            swordCount += 1
//        case 1:
//            position.y += tileSize
//            swordCount += 1
//        case 2:
//            position.y += tileSize
//            swordCount += 1
//        default:
//            self.physicsBody = nil
//            self.removeFromParent()
//
//        }
        
        
    }
    
}
