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
    
    var movementManager: MovementManager!
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundMap = (childNode(withName: "background") as! SKTileMapNode)
        obstaclesTileMap = (childNode(withName: "obstacles")as! SKTileMapNode)
        
        movementManager = MovementManager(self, camera!)
        
        
    }
    
    override func sceneDidLoad() {
        
    
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        movementManager.checkInput(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        movementManager.checkInput(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        movementManager.stopMovement()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        //Game logic for updating movement goes in movementManagers update()-method
        movementManager.update()
        
    }
}
