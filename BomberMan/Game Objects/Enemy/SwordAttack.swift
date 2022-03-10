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
    var swordAnchor = SKSpriteNode()
    var enemyAttacking: TestEnemy?
    var direction: Direction?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(attackDirection: Direction){
        
        //declaring all necessary variables
        
        let swordTexture = SKTexture()
        let swordSize = CGSize(width: tileSize, height: tileSize)
        //create sprite node for sword attack
        super.init(texture: swordTexture, color: .white, size: swordSize)
        //setup physics body
        physicsBody = SKPhysicsBody(circleOfRadius: (size.width/4) * physicsBodyPct)
        physicsBody?.categoryBitMask = PhysicsCategory.Sword
        physicsBody?.collisionBitMask = PhysicsCategory.All
        physicsBody?.contactTestBitMask = PhysicsCategory.All
        physicsBody?.restitution = 0
        physicsBody?.isDynamic = false
        physicsBody?.friction = 0
        physicsBody?.allowsRotation = false
        
        texture = SKTexture(imageNamed: getTexture(attackDirection: attackDirection))
        
        Enemy.attacks.append(self)
    }
    
    func getTexture(attackDirection: Direction) -> String{
        
        switch attackDirection {
        case .forward:
            direction = .forward
            return "sword_swing_up_side"
            
        case .backward:
            direction = .backward
            return "sword_swing_under_side"
            
        case .left:
            direction = .left
            return "sword_swing_right_side"
            
        case .right:
            direction = .right
            return "sword_swing_left_side"
            
        }
        
    }
    
    func setPositions(with other: SKNode, enemyNode: SKNode){
        
        let enemy = enemyNode as! TestEnemy
        enemyAttacking = enemy
        let player = other as! Player
        let swordPos = CGPoint(x: player.position.x, y: player.position.y)
        position = swordPos
        zPosition = 50
        enemyAttacking!.isAttacking = true
        
    }
    
    func update(){
        
        var positionToChange: CGFloat
        
        if direction == .forward || direction == .backward{
            
            positionToChange = position.x
            
        }else{
            
            positionToChange = position.y
        }
        
        if swordCount < 5{
            positionToChange += 1
            swordCount += 1
            
            if swordCount == 4{
                zRotation -= 0.3
            }
            
        }else if swordCount < 10{
            positionToChange += 2
            swordCount += 1
            
            if swordCount == 9{
                zRotation -= 0.3
            }
            
        }else if swordCount < 15{
            
            positionToChange += 2
            swordCount += 1
            
            if swordCount == 14{
                zRotation -= 0.3
            }
            
        }else{
            self.physicsBody = nil
            self.removeFromParent()
            guard let toRemove = Enemy.attacks.firstIndex(of: self) else { return }
            Enemy.attacks.remove(at: toRemove)
            enemyAttacking?.isAttacking = false
        }
    }
}
