//
//  BombPile.swift
//  BomberMan
//
//  Created by Hampus Brandtman on 2022-02-22.
//

import Foundation
import GameplayKit

class BombPile: LootObject {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init() {
        
        let texture = SKTexture(imageNamed: "BombPile")
        super.init(texture, .white, (GameScene.tileSize)!)
        name = "bomb loot"
        zPosition = 50
    }
    override func collision(loot: SKNode?) {
        
        PlayerSettingsUI.instance.haveBombs = true
        print("loot collision bombpile")
        SoundManager.playSFX(SoundManager.lootBombsSFX)
        super.collision(loot: loot)
        
        
    }
}
