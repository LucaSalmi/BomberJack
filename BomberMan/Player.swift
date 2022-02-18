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
    static var frame: Int = 0
}

class Player: SKSpriteNode{
    
    static var camera: SKCameraNode! = SKCameraNode()
    var animations: [SKAction] = []
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(){
        let texture = SKTexture(imageNamed: "player_walk_right_1")
        let size: CGSize = CGSize(width: 26.0, height: 48.0)
        
        super.init(texture: texture, color: .white, size: size)
        name = "Player"
        zPosition = 50
        
        physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        physicsBody?.categoryBitMask = PhysicsCategory.Player
        physicsBody?.contactTestBitMask = PhysicsCategory.Breakable
        physicsBody?.restitution = 0
        physicsBody?.allowsRotation = false
        
        createAnimations(character: "player_walk")
        
    }
    
    func move(direction: CGPoint){
        
        self.position.x += (direction.x * PlayerSettings.playerSpeed)
        self.position.y += (direction.y * PlayerSettings.playerSpeed)
        runAnim()
        //let move = SKAction.move(to: target, duration: 1)
        //run(move)
    }
    
    func runAnim(){
        if PlayerSettings.frame <= 4{
            
            run(animations[PlayerSettings.frame], withKey: "animation")
            PlayerSettings.frame += 1
            
        }else{
            
            PlayerSettings.frame = 0
            run(animations[PlayerSettings.frame], withKey: "animation")
        }
        
    }

    func collision(with other: SKNode?) {
        
        
            print("collision happened")
        
        
    }
}

extension Player: Animatable{}
