//
//  SoundManager.swift
//  BomberMan
//
//  Created by Luca Salmi, Daniel Falkedal, Calle Höglund, Hampus Brandtman on 2022-02-18.
//

import Foundation
import GameplayKit

class SoundManager {
    
    static let sfxExtension = ".wav"
    
    static let explosionSFX = "explosion1"
    //sfx 2
    //sfx 3 etc...
    
    static func playSFX(_ sfx: String, _ context: GameScene) {
        
        if GameViewController.currentGameScene == nil {
            return
        }
        
        let sfxName = sfx + sfxExtension
        let sfxAction = SKAction.playSoundFileNamed(sfxName, waitForCompletion: false)
        GameViewController.currentGameScene!.run(sfxAction)
    }
    
}
