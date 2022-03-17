//
//  Explosion.swift
//  BomberMan
//
//  Created by Luca Salmi, Daniel Falkedal, Calle Höglund, Hampus Brandtman on 2022-02-18.
//

import Foundation
import SpriteKit

enum ExplosionSettings{
    
    static var range: Int = 1
    static var size: Int = 5
    static var distancePos: CGFloat = 32
    static var distanceNeg: CGFloat = -32
    static var permanence: Int = 30
    static var explosionsArray: [Explosion] = []
    static var explosionId: Int = 0
    
    
}

class Explosion: SKSpriteNode{
    
    static let physicsBodyPct = CGFloat(0.85)
    var count: Int = 0
    var explosionPart: Int
    var animationArray: [SKAction] = [SKAction]()
    var actualFrame = 0
    var maxFrame = 0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(position: CGPoint, explosionAnimPart: Int){
        
        let texture = SKTexture(imageNamed: "explosion1")
        let size: CGSize = GameScene.tileSize ?? CGSize(width: 32, height: 32)
        explosionPart = explosionAnimPart
        super.init(texture: texture, color: .white, size: size)
        self.position = position
        zPosition = -98
        name = "Explosion\(ExplosionSettings.explosionId)"
        ExplosionSettings.explosionId += 1
        prepareAnimation()
        
    }
    
    func prepareAnimation(){
        var frameName: String = ""
        switch explosionPart{
            
            //center
        case 0:
            frameName = "start explosion middle "
            
            //right
        case 1:
            frameName = "start explosion right "
            
            //left
        case 2:
            frameName = "start explosion left "
            
            //top
        case 3:
            frameName = "start explosion top "
            
            //bottom
        case 4:
            frameName = "start explosion bottom "
            
        default:
            print("error")
        }
        
        for i in 1...5{
            
            let anim: SKAction
            
            if i == 5{
                
                anim = SKAction.animate(with: [SKTexture(imageNamed: "\(frameName)\(i)"), SKTexture(imageNamed: "\(frameName)1")], timePerFrame: 0.4)
                
            }else{
                
                anim = SKAction.animate(with: [SKTexture(imageNamed: "\(frameName)\(i)"), SKTexture(imageNamed: "\(frameName)\(i+1)")], timePerFrame: 0.4)
                
            }
            
            animationArray.append(anim)
            
        }
        
        maxFrame = animationArray.count - 1
    }
    
    func createPhysicsBody(){
        
        physicsBody = SKPhysicsBody(circleOfRadius: (size.width/2) * Explosion.physicsBodyPct)
        physicsBody?.categoryBitMask = PhysicsCategory.Explosion
        physicsBody?.collisionBitMask = PhysicsCategory.All
        physicsBody?.contactTestBitMask = PhysicsCategory.All
        physicsBody?.restitution = 0
        physicsBody?.isDynamic = false
        physicsBody?.friction = 0
        physicsBody?.allowsRotation = false
    }
    
    func update(){
       
        count += 1
        
        if count == 1{
            createPhysicsBody()
        }
        
        if count >= ExplosionSettings.permanence{
            
            count = 0
            self.removeFromParent()
            ExplosionSettings.explosionsArray.remove(at: ExplosionSettings.explosionsArray.firstIndex(of: self)!)
        }else{
            
            runAnimation()
            
        }
        
    }
    
    func runAnimation(){
        
        if actualFrame == maxFrame{
            
            print("actual \(actualFrame)")
            print("max \(maxFrame)")
            print("array \(animationArray.count)")
            self.run(animationArray[maxFrame])
            actualFrame -= 1
            return
        }
        
        self.run(animationArray[actualFrame])
        
        actualFrame += 1
        
        
    }
}
