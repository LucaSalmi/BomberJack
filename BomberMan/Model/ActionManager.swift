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
    var shieldButton: SKSpriteNode? = nil
    var touchLocation: CGPoint? = nil
    
    init(_ context: GameScene, _ camera: SKCameraNode) {
        
        self.context = context
        self.camera = camera
        
        rightUI = (context.childNode(withName: "camera/rightUI") as! SKSpriteNode)
        nextLevelButton = (context.childNode(withName: "camera/rightUI/nextLevelButton") as! SKSpriteNode)
        bombButton = (context.childNode(withName: "camera/rightUI/bombButton") as! SKSpriteNode)
        shieldButton = (context.childNode(withName: "camera/rightUI/shieldButton") as! SKSpriteNode)
        
        if (PlayerSettings.haveBombs == false) {
            bombButton?.alpha = 0.2
        }
    }
    
    func checkInput(_ touches: Set<UITouch>, with event: UIEvent?){
        for touch in touches {
            
            let location = touch.location(in: rightUI!)
            //print(location)
            let currentNode = rightUI!.atPoint(location)
            let currentNodeName = currentNode.name
            
            if (currentNodeName == "bombButton" && PlayerSettings.haveBombs == true && GameScene.gameState == .play){
                
                placeBomb(id: 0)
                
            }
            else if (currentNodeName == "shieldButton" && GameScene.gameState == .play) {
                activateShield()
            }
            else if (currentNodeName == "nextLevelButton" && GameScene.gameState == .play) {
                nextLevel()
            }
            else if currentNodeName == "trapButton" && GameScene.gameState == .play{
                
                print("trapSet")
                placeBomb(id: 1)
            }
            else if currentNodeName == "pauseButton"{
                
                if GameScene.gameState == .play{
                    GameScene.gameState = .pause
                }else{
                    GameScene.gameState = .play
                }
                
            }
        }
    }
            
    func placeBomb(id: Int){
        
        if GameViewController.currentGameScene!.player!.isShielded {
            return
        }
        //stat change
        UserData.bombsDropped += 1
        
        var bomb: Bomb
        
        switch id {
            
        case 0:
            bomb = StandardBomb()
            
        case 1:
            bomb = TrapBomb()
            
        default:
            bomb = StandardBomb()
        }
        
        
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
        
        
        if !PhysicsUtils.checkIfOccupied(node: context.bombsNode!, object: bomb){
            
            context.bombsNode!.addChild(bomb)
            Bomb.bombs.append(bomb)
            
        }else{
            return
        }
        
    }
    
    func activateShield() {
        
        //stat change
        UserData.barrelUsed += 1
        
        if GameViewController.currentGameScene == nil  {
            return
        }
        
        let player = GameViewController.currentGameScene!.player
        player!.activateShield()

    }
    
    func nextLevel() {
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
