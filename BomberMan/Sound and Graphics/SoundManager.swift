//
//  SoundManager.swift
//  BomberMan
//
//  Created by Luca Salmi, Daniel Falkedal, Calle Höglund, Hampus Brandtman on 2022-02-18.
//

import Foundation
import GameplayKit
import AVFAudio

class SoundManager {
    
    static let sfxExtension = ".wav" // with . (dot)
    static let bgmExtension = "mp3" // without . (dot)
    
    static let explosionSFX = "explosion1"
    static let barrelShieldSFX = "barrel_shield"
    static let rushImpactSFX = "rush_impact"
    static let bloodSplatterSFX = "blood_splatter"
    static let doorOpenSFX = "door_sound"
    
    static let mainMenuBGM = "main_menu_bgm"
    static let inGameBGM = "in_game_bgm"
    
    static var musicPlayer: AVAudioPlayer?
    
    static func playSFX(_ sfx: String) {
        
        if GameViewController.currentGameScene == nil {
            return
        }
        
        let sfxName = sfx + sfxExtension
        let sfxAction = SKAction.playSoundFileNamed(sfxName, waitForCompletion: false)
            GameViewController.currentGameScene!.run(sfxAction)
    }
    
    static func playBGM(bgmString: String) {
        
        musicPlayer?.stop()
        
        let bgm = Bundle.main.path(forResource: bgmString, ofType: "mp3")
        
        do {
            let url = URL(fileURLWithPath: bgm!)
            musicPlayer = try AVAudioPlayer(contentsOf: url)
            
        } catch {
            
        }
        musicPlayer!.play()
        musicPlayer!.numberOfLoops = -1
    }
    
}
