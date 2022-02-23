//
//  key_one.swift
//  BomberMan
//
//  Created by Hampus Brandtman on 2022-02-22.
//

import Foundation
import GameplayKit

class Key: LootObject {
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init() {
        
        let texture = SKTexture(imageNamed: "keyOneLoot")
        super.init(texture, .white, (GameScene.tileSize)!)
        name = "key object"
        zPosition = 50
    }
    override func collision(loot: SKNode?) {
        print("loot collision key")
        PlayerSettings.amountOfKeys += 1
        super.collision(loot: loot)
        
        
    }
}
