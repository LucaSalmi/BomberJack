//
//  GameScene.swift
//  BomberMan
//
//  Created by Luca Salmi on 2022-02-09.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var backgroundMap: SKTileMapNode!
    var obstaclesTileMap: SKTileMapNode?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundMap = (childNode(withName: "background") as! SKTileMapNode)
        obstaclesTileMap = (childNode(withName: "obstacles")as! SKTileMapNode)
    }
    
    override func sceneDidLoad() {
        
    
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
}
