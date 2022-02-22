//
//  key_one.swift
//  BomberMan
//
//  Created by Hampus Brandtman on 2022-02-22.
//

import Foundation
import GameplayKit

class Key: LootObject {
    
    var gotKeyOne = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init() {
        
        let texture = SKTexture(imageNamed: "keyOneLoot")
        super.init(texture, .white, (GameScene.tileSize)!)
        name = "key object"
        zPosition = 50
    }
}
