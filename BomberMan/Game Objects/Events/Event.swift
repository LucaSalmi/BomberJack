//
//  Event.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-02-28.
//

import Foundation
import GameplayKit

enum EventIDs {
    
    static let needBombsHint = "needBombsHint"
    
}

class Event: SKSpriteNode {

    var eventType: String = ""
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(_ color: UIColor, _ size: CGSize){
        
        let texture = SKTexture(imageNamed: "event")
        super.init(texture: texture, color: color, size: size)
        alpha = 0
        print("event initilized")
        createPhysicsBody()
    }
    func createPhysicsBody(){
        
        physicsBody = SKPhysicsBody(circleOfRadius: (size.width/2) * PhysicsUtils.physicsBodyPct)
        physicsBody?.categoryBitMask = PhysicsCategory.Event
        physicsBody?.contactTestBitMask = PhysicsCategory.Player
        physicsBody?.collisionBitMask = PhysicsCategory.Player
        physicsBody?.isDynamic = false
        
    }
    
    func collision(node: SKNode?) {
        print("Event type \(eventType) triggered!")
        self.removeFromParent()
    }
    
    func triggerEvent() {
        //override this!
    }
    
}
