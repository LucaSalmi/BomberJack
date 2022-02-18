//
//  Player.swift
//  BomberMan
//
//  Created by Luca Salmi, Daniel Falkedal, Calle Höglund, Hampus Brandtman on 2022-02-15.
//

import Foundation
import SpriteKit

enum PlayerSettings{
    static let playerSpeed: CGFloat = 1.5
}

class Player: SKSpriteNode{
    
    static var camera: SKCameraNode! = SKCameraNode()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(){
        let texture = SKTexture(imageNamed: "player_tf2")
        let size: CGSize = CGSize(width: 26.0, height: 48.0)
        
        super.init(texture: texture, color: .white, size: size)
        name = "Player"
        zPosition = 50
        
        physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        physicsBody?.categoryBitMask = PhysicsCategory.Player
        physicsBody?.contactTestBitMask = PhysicsCategory.Breakable
        physicsBody?.restitution = 0
        physicsBody?.allowsRotation = false
        
    }
    
    func move(direction: CGPoint){
        
        self.position.x += (direction.x * PlayerSettings.playerSpeed)
        self.position.y += (direction.y * PlayerSettings.playerSpeed)
        
        //let move = SKAction.move(to: target, duration: 1)
        //run(move)
    }
    

    func collision(with other: SKNode?) {
        
        
            print("collision happened")
        
        
    }
}
