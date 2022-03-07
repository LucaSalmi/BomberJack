//
//  Breakable Fence.swift
//  BomberMan
//
//  Created by Luca Salmi on 2022-03-07.
//

import Foundation
import SpriteKit

class Fence: BreakableObject{
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    override init(textureName: String) {
        super.init(textureName: textureName)
        name = "Breakable Fence"
    }
    
    override func createPhysicsBody(tile: SKTileDefinition) {
        super.createPhysicsBody(tile: tile)
    }
    
    override func collision(breakable: SKNode?) {
        
        let obj = breakable as! Fence
        obj.breakableTexture.removeFromParent()
        changeTexture(obj: obj)
        super.collision(breakable: breakable)
        
    }
    
    //When destroying the obj changes the texture to another without a Physics Body
    private func changeTexture(obj: Fence){
        
        var size = GameScene.tileSize
        size?.height += BreakableSettings.sizeOffset
        size?.width += 8 // temporary
        obj.breakableTexture = SKSpriteNode(texture: SKTexture(imageNamed: "trashed_fence"), size: size!)
        obj.breakableTexture.position = obj.position
        obj.breakableTexture.zPosition = obj.zPosition
        GameViewController.currentGameScene?.breakablesNode?.addChild(obj.breakableTexture)
        
    }
    
    
    
    
}
