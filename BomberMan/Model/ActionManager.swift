//
//  ActionManager.swift
//  BomberMan
//
//  Created by Luca Salmi, Daniel Falkedal, Calle Höglund, Hampus Brandtman on 2022-02-16.
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
                
                placeBomb()
                
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
    
    func placeBomb(){
        
        let bomb = Bomb()
        
        let backgroundMap = context.backgroundMap!
        let player = context.player!
        
        var tileFound = false
        
        for row in 0..<backgroundMap.numberOfRows{
            for column in 0..<backgroundMap.numberOfColumns{
                guard let tile = context.tile(in: backgroundMap, at: (column, row)) else {
                    continue
                 }
                
                let tilePosition = backgroundMap.centerOfTile(atColumn: column, row: row)
                
                let leftSide = tilePosition.x - (tile.size.width/2)
                let topSide = tilePosition.y + (tile.size.height/2)
                let rightSide = tilePosition.x + (tile.size.width/2)
                let bottomSide = tilePosition.y - (tile.size.height/2)
                
                if player.position.x > leftSide && player.position.x < rightSide{
                    if player.position.y > bottomSide && player.position.y < topSide{
                        bomb.position = tilePosition
                        tileFound = true
                        break
                    }
                }
            }
            
            if tileFound {break}
        }
        
        bomb.texture = SKTexture(imageNamed: "bomb1")
        
        if !PhysicsUtils.checkIfOccupied(node: context.bombsNode, object: bomb){
            
            context.bombsNode.addChild(bomb)
            Bomb.bombs.append(bomb)
            
        }else{
            return
        }
        
    }
}
