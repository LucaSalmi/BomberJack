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
    static let barrelShieldSFX = "barrel_shield"
    //sfx 3 etc...
    
    static func playSFX(_ sfx: String) {
        
        if GameViewController.currentGameScene == nil {
            return
        }
        
        let sfxName = sfx + sfxExtension
        let sfxAction = SKAction.playSoundFileNamed(sfxName, waitForCompletion: false)
        GameViewController.currentGameScene!.run(sfxAction)
    }
    
}
