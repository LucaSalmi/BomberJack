//
//  BreakableObject.swift
//  BomberMan
//
//  Created by Luca Salmi, Daniel Falkedal, Calle Höglund, Hampus Brandtman on 2022-02-15.
//

import Foundation
import SpriteKit

enum BreakableSettings{
    
    static let sizeOffset: CGFloat = 25
    
}

class BreakableObject: SKSpriteNode{
    
    var breakableTexture: SKSpriteNode
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(textureName: String, yOffset: CGFloat){
        
        //Texture Init
        let objTexture = SKTexture(imageNamed: textureName)
        var size = GameScene.tileSize
        size?.height += yOffset
        size?.width += 8 // temporary
        breakableTexture = SKSpriteNode(texture: objTexture, color: .clear, size: size!)
        
        super.init(texture: nil, color: .clear, size: GameScene.tileSize!)
        zPosition = 50

    }
    
    func createPhysicsBody(tile: SKTileDefinition){
        
        physicsBody = SKPhysicsBody(circleOfRadius: (tile.size.width/2) * PhysicsUtils.physicsBodyPct)
        physicsBody?.categoryBitMask = PhysicsCategory.Breakable
        physicsBody?.collisionBitMask = 0
        physicsBody?.isDynamic = true
        
        lightingBitMask = 1
    }
    
    func collision(breakable: SKNode?) {
        
        breakable?.removeFromParent()
        breakable?.physicsBody = nil
        
    }
    
    //When destroying the obj changes the texture to another without a Physics Body
    func changeTexture(obj: BreakableObject){
        
        var imageName = ""
        
        if obj is Fence {
            imageName = "trashed_fence"
        }
        else if obj is Tree {
            imageName = "trashed_fence"
        }
        else {
            imageName = "trashed_fence"
        }
        
        var size = GameScene.tileSize
        size?.height += BreakableSettings.sizeOffset
        size?.width += 8 // temporary
        obj.breakableTexture = SKSpriteNode(texture: SKTexture(imageNamed: imageName), size: size!)
        obj.breakableTexture.position = obj.position
        obj.breakableTexture.zPosition = obj.zPosition - 1
        GameViewController.currentGameScene?.breakablesNode?.addChild(obj.breakableTexture)
        
    }
}
