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
    static var frameLimiter: Int = 1
}

class Player: SKSpriteNode{
    
    static var camera: SKCameraNode! = SKCameraNode()
    var rightAnimations: [SKAction] = []
    var leftAnimations: [SKAction] = []
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(){
        let texture = SKTexture(imageNamed: "player_walk_up_1")
        let size: CGSize = CGSize(width: 26.0, height: 48.0)
        
        super.init(texture: texture, color: .white, size: size)
        name = "Player"
        zPosition = 50
        
        physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        physicsBody?.categoryBitMask = PhysicsCategory.Player
        physicsBody?.contactTestBitMask = PhysicsCategory.Breakable
        physicsBody?.restitution = 0
        physicsBody?.allowsRotation = false
        
        createPlayerAnimations(character: "player_walk")
        
    }
    
    func move(direction: CGPoint){
        
        self.position.x += (direction.x * PlayerSettings.playerSpeed)
        self.position.y += (direction.y * PlayerSettings.playerSpeed)
        let direction = findDirection(playerDirection: direction)
        
        runAnim(playerDirection: direction)
        //let move = SKAction.move(to: target, duration: 1)
        //run(move)
    }
    
    func findDirection(playerDirection: CGPoint) -> Direction{
        
        
        if playerDirection.x == 1{
            return .right
        }
        if playerDirection.x == -1{
            return .left
        }
        if playerDirection.y == 1{
            return .forward
        }
        if playerDirection.y == -1{
            return .backward
        }
        
        return .right
    }
    
    func runAnim(playerDirection: Direction){
        
        if PlayerSettings.frame > 4{
            PlayerSettings.frame = 0
        }
        
        switch playerDirection {
            
        case .forward:
            self.texture = SKTexture(pixelImageNamed: "player_walk_up_1")
        case .backward:
            run(rightAnimations[PlayerSettings.frame], withKey: "animation")
        case .left:
            run(leftAnimations[PlayerSettings.frame], withKey: "animation")
        case .right:
            run(rightAnimations[PlayerSettings.frame], withKey: "animation")
        }
        
        if PlayerSettings.frameLimiter > 4{
            
            PlayerSettings.frame += 1
            PlayerSettings.frameLimiter = 1
        }
        
        PlayerSettings.frameLimiter += 1
        
    }

    func collision(with other: SKNode?) {
        
        print("collision happened")
        
    }
}

extension Player: Animatable{}
