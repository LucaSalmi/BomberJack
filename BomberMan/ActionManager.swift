//
//  ActionManager.swift
//  BomberMan
//
//  Created by Calle Höglund on 2022-02-16.
//

import Foundation
import SpriteKit

class ActionManagager{
    
    var context: GameScene!
    var camera: SKCameraNode? = nil
    
    var rightUI: SKSpriteNode? = nil
    var nextLevelButton: SKSpriteNode? = nil
    var bombButton: SKSpriteNode? = nil
    var touchLocation: CGPoint? = nil
    
    init(_ context: GameScene, _ camera: SKCameraNode) {
        
        self.context = context
        self.camera = camera
        
        rightUI = (context.childNode(withName: "camera/rightUI") as! SKSpriteNode)
        nextLevelButton = (context.childNode(withName: "camera/rightUI/nextLevelButton") as! SKSpriteNode)
        bombButton = (context.childNode(withName: "camera/rightUI/bombButton") as! SKSpriteNode)
    }
    
    func checkInput(_ touches: Set<UITouch>, with event: UIEvent?){
        for touch in touches {
            
            
            
            
            let location = touch.location(in: rightUI!)
            //print(location)
            let currentNode = rightUI!.atPoint(location)
            let currentNodeName = currentNode.name
            
            
            
            if (currentNodeName == "bombButton"){
                
                context.placeBomb()
                
            }
            else if (currentNodeName == "nextLevelButton") {
                print("Presenting next level!")
                if GameScene.viewController == nil {
                    print("Could not find Game View Controller!")
                    return
                }
                GameScene.viewController!.currentLevel += 1
                if GameScene.viewController!.currentLevel > GameScene.viewController!.numberOfLevels {
                    GameScene.viewController!.currentLevel = GameScene.viewController!.numberOfLevels
                }
                let nextScene = "GameScene" + String(GameScene.viewController!.currentLevel)
                GameScene.viewController!.presentScene(nextScene)
            }
            
            
        }
    }
}
