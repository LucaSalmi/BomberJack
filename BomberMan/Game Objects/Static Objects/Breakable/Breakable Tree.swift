//
//  Breakable Tree.swift
//  BomberMan
//
//  Created by Luca Salmi on 2022-03-07.
//

import Foundation
import SpriteKit

class Tree: BreakableObject{
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    override init(textureName: String) {
        super.init(textureName: textureName)
        name = "Breakable Tree"
    }
    
    override func createPhysicsBody(tile: SKTileDefinition) {
        super.createPhysicsBody(tile: tile)
    }
    
    override func collision(breakable: SKNode?) {
        let obj = breakable as! Tree
        obj.breakableTexture.removeFromParent()
        super.collision(breakable: breakable)
    }
    
    
    
    
    
}
