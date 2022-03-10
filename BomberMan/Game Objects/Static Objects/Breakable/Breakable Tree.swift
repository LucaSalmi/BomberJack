//
//  Breakable Tree.swift
//  BomberMan
//
//  Created by Luca Salmi on 2022-03-07.
//

import Foundation
import SpriteKit

enum TreeSettings{
    
    static let sizeOffset: CGFloat = 35
    
}

class Tree: BreakableObject{
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(textureName: String) {
        super.init(textureName: textureName, yOffset: TreeSettings.sizeOffset)
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
