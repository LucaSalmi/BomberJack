//
//  SoundManager.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-02-18.
//

import Foundation
import GameplayKit

class SoundManager {
    
    static let sfxExtension = ".wav"
    
    static let explosionSFX = "explosion1"
    //sfx 2
    //sfx 3 etc...
    
    static func playSFX(_ sfx: String, _ context: GameScene) {
        
        let sfxName = sfx + sfxExtension
        let sfxAction = SKAction.playSoundFileNamed(sfxName, waitForCompletion: false)
        context.run(sfxAction)
    }
    
}
