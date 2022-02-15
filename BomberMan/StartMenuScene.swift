//
//  StartMenuScene.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-02-15.
//

import Foundation
import GameplayKit

class StartMenuScene: SKScene {
    
    var viewController: GameViewController? = nil
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            
            let startButton = atPoint(location)
            
            if startButton.name == "startButton" {
                
                self.viewController?.presentScene("GameScene")
                
            }
            
        }
    }
    
}
