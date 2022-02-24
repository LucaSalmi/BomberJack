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
    static var canDropBomb: Bool = true // temporary not using
    static let textureOffset = CGFloat(10) //temporary hard coded variable
    static let shieldDuration: CGFloat = 60 * 2
    static var haveBombs: Bool = false
    static var amountOfKeys = 0
}

class Player: SKSpriteNode{
    
    static var camera: SKCameraNode! = SKCameraNode()
    //Graphics variables
    var rightAnimations: [SKAction] = []
    var leftAnimations: [SKAction] = []
    var upAnimations: [SKAction] = []
    var downAnimations: [SKAction] = []
    var playerTexture: SKSpriteNode! = SKSpriteNode()
    var shieldTexture: SKSpriteNode! = SKSpriteNode()
    var currentTexture: SKSpriteNode! = SKSpriteNode()
    //Logic variables
    var isTrapped = false
    var isShielded = false
    var shieldTick: CGFloat = 0.0
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(){
        let texture = SKTexture(imageNamed: "player_walk_up_1")
        let size: CGSize = CGSize(width: 32, height: 32)
        let tempColor = UIColor(red: 100, green: 100, blue: 100, alpha: 0)
        super.init(texture: SKTexture(imageNamed: "player_shadow"), color: tempColor, size: size)
        name = "Player"
        zPosition = 1
        
        physicsBody = SKPhysicsBody(circleOfRadius: (size.width/2) * PhysicsUtils.physicsBodyPct)
        physicsBody?.categoryBitMask = PhysicsCategory.Player
        physicsBody?.collisionBitMask = PhysicsCategory.Bomb | PhysicsCategory.Obstacle | PhysicsCategory.Enemy | PhysicsCategory.Breakable | PhysicsCategory.TrapBomb | PhysicsCategory.Loot | PhysicsCategory.Door
        //physicsBody?.contactTestBitMask = PhysicsCategory.Breakable
        physicsBody?.restitution = 0
        physicsBody?.allowsRotation = false
        
        let textureSize = CGSize(width: size.width, height: size.height*1.5)
        playerTexture = SKSpriteNode(texture: texture, color: UIColor(red: 0, green: 0, blue: 0, alpha: 0), size: textureSize)
        playerTexture.position = position
        playerTexture.zPosition = 50
        currentTexture = playerTexture
        GameViewController.currentGameScene!.addChild(playerTexture)
        
        let barrelTexture = SKTexture(imageNamed: "barrel_shield")
        let barrelTextureSize = CGSize(width: size.width, height: size.height*1.5)
        shieldTexture = SKSpriteNode(texture: barrelTexture, color: .red, size: barrelTextureSize)
        shieldTexture.position = position
        shieldTexture.zPosition = 50
        shieldTexture.alpha = 0
        GameViewController.currentGameScene!.addChild(shieldTexture)
        
        createPlayerAnimations(character: "player_walk")
        
    }
    
    func activateShield() {
        if isShielded {
            return
        }
        
        let smokeParticle = SKEmitterNode(fileNamed: "BarrelSmoke")
        smokeParticle!.position = position
        smokeParticle!.position.y += 16
        smokeParticle!.zPosition = 100
        GameViewController.currentGameScene!.addChild(smokeParticle!)
        GameViewController.currentGameScene!.run(SKAction.wait(forDuration: 1)) {
            smokeParticle!.removeFromParent()
        }
        SoundManager.playSFX(SoundManager.barrelShieldSFX)
  
        physicsBody?.isDynamic = false
        shieldTick = 0.0
        shieldTexture.alpha = 1
        playerTexture.alpha = 0
        currentTexture = shieldTexture
        isShielded = true
    }
    
    func deactivateShield() {
        
        physicsBody?.isDynamic = true
        shieldTexture.alpha = 0
        playerTexture.alpha = 1
        currentTexture = playerTexture
        
        shieldTick = 0
        isShielded = false
    }
    
    func move(direction: CGPoint){
        
        if isShielded {
            return
        }
        
        if !isTrapped {
            
            self.position.x += (direction.x * PlayerSettings.playerSpeed)
            self.position.y += (direction.y * PlayerSettings.playerSpeed)
            let direction = findDirection(playerDirection: direction)
            
            runAnim(playerDirection: direction)
        }
        
        
    }
    
    func bloodParticle() {
        let bloodParticle = SKEmitterNode(fileNamed: "BloodSplatter")
        bloodParticle!.position = position
        bloodParticle!.zPosition = 100
        GameViewController.currentGameScene!.addChild(bloodParticle!)
        GameViewController.currentGameScene!.run(SKAction.wait(forDuration: 1)) {
            bloodParticle!.removeFromParent()
        }
        SoundManager.playSFX(SoundManager.bloodSplatterSFX)
    }
    
    func death(player: SKNode){
        //
        let deathParticle = SKEmitterNode(fileNamed: "EnemyDeath")
        deathParticle!.particleTexture = playerTexture.texture
        deathParticle!.position = playerTexture.position
        deathParticle!.zPosition = 100
        GameViewController.currentGameScene!.addChild(deathParticle!)
        GameViewController.currentGameScene!.run(SKAction.wait(forDuration: 1)) {
            deathParticle!.removeFromParent()
        }
        //Play sound SFX on death?
        
        //stat change
        UserData.numberOfDeaths += 1
        
        player.removeFromParent()
        currentTexture.removeFromParent()
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
        
        if PlayerSettings.frame > rightAnimations.count - 1 || PlayerSettings.frame > leftAnimations.count - 1{
            PlayerSettings.frame = 0
        }
        
        switch playerDirection {
            
        case .forward:
            playerTexture.run(upAnimations[PlayerSettings.frame], withKey: "animation")
        case .backward:
            playerTexture.run(downAnimations[PlayerSettings.frame], withKey: "animation")
        case .left:
            playerTexture.run(leftAnimations[PlayerSettings.frame], withKey: "animation")
        case .right:
            playerTexture.run(rightAnimations[PlayerSettings.frame], withKey: "animation")
        }
        
        if PlayerSettings.frameLimiter > rightAnimations.count - 1 || PlayerSettings.frameLimiter > leftAnimations.count - 1{
            
            PlayerSettings.frame += 1
            PlayerSettings.frameLimiter = 1
        }
        
        PlayerSettings.frameLimiter += 1
        
    }

    func collision(with other: SKNode?) {
        
        print("collision happened")
        
    }
    
    func update() {
        
        if currentTexture != nil{
            
            currentTexture.position.x = position.x
            currentTexture.position.y = position.y + PlayerSettings.textureOffset
        }
        
        if isShielded {
            shieldTick += 1
            if shieldTick >= PlayerSettings.shieldDuration {
                deactivateShield()
            }
        }
        
    }
}

extension Player: Animatable{}
