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
    var bombButton: SKSpriteNode? = nil
    var touchLocation: CGPoint? = nil
    
    init(_ context: GameScene, _ camera: SKCameraNode) {
        
        self.context = context
        self.camera = camera
        
        rightUI = (context.childNode(withName: "camera/rightUI") as! SKSpriteNode)
        bombButton = (context.childNode(withName: "camera/rightUI/bombButton") as! SKSpriteNode)
    }
    
    func checkInput(_ touches: Set<UITouch>, with event: UIEvent?){
        for touch in touches {
            
            
            
            
            let location = touch.location(in: rightUI!)
            //print(location)
            let currentNode = rightUI!.atPoint(location)
            let currentNodeName = currentNode.name
            
            
            
            if (currentNodeName == "bombButton"){
                print("boom fire bitch")
                context.placeBomb()
                
            }
            
            
        }
    }
}
