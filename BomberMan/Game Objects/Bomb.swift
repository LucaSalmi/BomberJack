//
//  Bomb.swift
//  BomberMan
//
//  Created by Luca Salmi, Daniel Falkedal, Calle Höglund, Hampus Brandtman on 2022-02-16.
//

import Foundation
import SpriteKit

enum BombSettings{
    
    static let explosionTime: Int = 60 * 3
    static let blastRadius: Int = 1
    
}

class Bomb: SKSpriteNode{
    
    static var bombs = [Bomb]()
    var activePhysicsBody: SKPhysicsBody?
    var inactivePhysicsBody: SKPhysicsBody?
    
    var tickingTime: Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(_ texture: SKTexture, _ color: UIColor, _ size: CGSize){
        
        super.init(texture: texture, color: color, size: size)
        createPhysicsBody()
    }
    
    func createPhysicsBody(){
        
        physicsBody = SKPhysicsBody(circleOfRadius: (size.width/2) * PhysicsUtils.physicsBodyPct)
        physicsBody?.categoryBitMask = PhysicsCategory.InactiveBomb
        physicsBody?.collisionBitMask = 0
        physicsBody?.isDynamic = true
        physicsBody?.restitution = 0
        physicsBody?.friction = 0
        physicsBody?.allowsRotation = false
    }
    
    func explosion(_ position: CGPoint){
        //overridden in subclasses
    }

    
    func update() {
        //overridden in subclasses
    }
}
