//
//  StartMenuScene.swift
//  BomberMan
//
//  Created by Luca Salmi, Daniel Falkedal, Calle Höglund, Hampus Brandtman on 2022-02-15.
//

import Foundation
import GameplayKit

class StartMenuScene: SKScene {
    
    var viewController: GameViewController? = nil
    

    
    override func sceneDidLoad() {
        

    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            
            let startButton = atPoint(location)
            
            if startButton.name == "startButton" {
                
                let currentLevel = UserData.currentLevel
                var sceneName = "GameScene"
                sceneName.append(String(currentLevel as Int))
                self.viewController?.presentScene(sceneName)
                
            }
        }
    }
}
