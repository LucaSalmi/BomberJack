//
//  MovementManager.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-02-15.
//

import Foundation
import GameplayKit

class MovementManager {
    
    var context: GameScene!
    var camera: SKCameraNode? = nil
    
    //Joystick variables
    var virtualJoystick: SKSpriteNode? = nil
    var centerButton: SKSpriteNode? = nil
    var currentJoystickButton: SKNode? = nil
    var centerButtonPosition: CGPoint? = nil
    var touchLocation: CGPoint? = nil
    
    init(_ context: GameScene, _ camera: SKCameraNode) {
        self.context = context
        self.camera = camera
        
        //Joystick setup
        virtualJoystick = (context.childNode(withName: "camera/leftUI/virtualJoystick") as! SKSpriteNode)
        centerButton = (context.childNode(withName: "camera/leftUI/virtualJoystick/centerButton") as! SKSpriteNode)
        centerButtonPosition = centerButton!.position
        
        for node in virtualJoystick!.children {
            node.zPosition = 2
            node.alpha = 0.01
        }
        centerButton!.zPosition = 1
        centerButton!.alpha = 1
    }
    
    func checkInput(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let mainLocation = touch.location(in: context)
            let mainNode = context.atPoint(mainLocation)
            
            /*
            let leftSide = virtualJoystick!.position.x - ((virtualJoystick!.size.width)/2)
            let rightSide = virtualJoystick!.position.x + ((virtualJoystick!.size.width)/2)
            let topSide = virtualJoystick!.position.y + ((virtualJoystick!.size.height)/2)
            let bottomSide = virtualJoystick!.position.y - ((virtualJoystick!.size.height)/2)
            
            print(leftSide)
            print(mainLocation.x)
            
            if mainLocation.x < leftSide || mainLocation.x > rightSide {
                if mainLocation.y < bottomSide || mainLocation.y > topSide {
                    return
                }
            }
             */

            
            let location = touch.location(in: virtualJoystick!)
            let currentNode = virtualJoystick!.atPoint(location)
            let currentNodeName = currentNode.name
            
            print(currentNodeName)
            
            touchLocation = location
            
            if (currentNodeName == "rightButton" || currentNodeName == "downButton" || currentNodeName == "leftButton") || currentNodeName == "upButton" {
                currentJoystickButton = currentNode
            }
        }
    }
    
    func stopMovement() {
        currentJoystickButton = nil
        centerButton!.position = centerButtonPosition!
        touchLocation = nil
    }
    
    func update() {
        if currentJoystickButton != nil {
            
            let joystickButtonName = currentJoystickButton!.name
            
            var test: Int = 0
            
            switch (joystickButtonName) {
                
            case "rightButton":
                //TODO: Move player
                test = -1
                
                //Test only
                camera?.position.x += 1
            case "downButton":
                //TODO: Move player
                test = -1
                
                //Test only
                camera?.position.y -= 1
            case "leftButton":
                //TODO: Move player
                test = -1
                
                //Test only
                camera?.position.x -= 1
            default:
                //TODO: Move player
                test = -1
                
                //Test only
                camera?.position.y += 1
            }
        
            if touchLocation != nil && touchLocation != nil {
                centerButton!.position = touchLocation!
            }
            
        }
    }
    
}
