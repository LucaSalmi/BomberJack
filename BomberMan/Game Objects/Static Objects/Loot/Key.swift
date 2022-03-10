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
        
        let texture = SKTexture(imageNamed: "KeyOneLoot")
        super.init(texture, .white, (GameScene.tileSize)!)
        name = "key object"
        zPosition = 50
    }
    override func collision(loot: SKNode?) {
        print("loot collision key")
        PlayerSettingsUI.instance.amountOfKeys += 1
        SoundManager.playSFX(SoundManager.lootKeysSFX)
        super.collision(loot: loot)
        
        
    }
}
