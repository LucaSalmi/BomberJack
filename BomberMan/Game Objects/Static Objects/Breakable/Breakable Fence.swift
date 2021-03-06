//
//  Breakable Fence.swift
//  BomberMan
//
//  Created by Luca Salmi on 2022-03-07.
//

import Foundation
import SpriteKit

enum FenceSettings{
    
    static let sizeOffset: CGFloat = 10
    
}

class Fence: BreakableObject{
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(textureName: String) {
        super.init(textureName: textureName, yOffset: FenceSettings.sizeOffset)
        name = "Breakable Fence"
    }
    
    override func createPhysicsBody(tile: SKTileDefinition) {
        super.createPhysicsBody(tile: tile)
    }
    
    override func collision(breakable: SKNode?) {
        
        let obj = breakable as! Fence
        obj.breakableTexture.removeFromParent()
        
        let smokeParticle = SKEmitterNode(fileNamed: "BarrelSmoke")
        smokeParticle!.position = position
        smokeParticle!.position.y += 16
        smokeParticle!.zPosition = 100
        GameViewController.currentGameScene!.addChild(smokeParticle!)
        GameViewController.currentGameScene!.run(SKAction.wait(forDuration: 1)) {
            smokeParticle!.removeFromParent()
        }
        
        changeTexture(obj: obj)
        super.collision(breakable: breakable)
        
    }
    
    
    
    
    
    
}
