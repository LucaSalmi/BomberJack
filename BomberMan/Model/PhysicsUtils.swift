//
//  PhysicsUtils.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-02-21.
//

import Foundation
import GameplayKit

class PhysicsUtils {
    
    static func checkIfOccupied(node: SKNode, object: SKNode) -> Bool{
    
        let list = node.children
        for otherObject in list{
            if otherObject.position == object.position{
                return true
            }
        }
        return false
    }
    
    static func shakeCamera(duration: CGFloat) {
        
        guard let scene = GameViewController.currentGameScene else {return}
        
        let amplitudeX: CGFloat = 10;
        let amplitudeY: CGFloat = 6;
        let numberOfShakes = duration / 0.04;
        var actionsArray = [SKAction]();
        for _ in 1...Int(numberOfShakes) {
            // build a new random shake and add it to the list
            let moveX = CGFloat(arc4random_uniform(UInt32(amplitudeX))) - amplitudeX / 2;
            let moveY = CGFloat(arc4random_uniform(UInt32(amplitudeY))) - amplitudeY / 2;
            let shakeAction = SKAction.moveBy(x: moveX, y: moveY, duration: 0.02);
            shakeAction.timingMode = SKActionTimingMode.easeOut;
            actionsArray.append(shakeAction);
            actionsArray.append(shakeAction.reversed());
        }

        let actionSeq = SKAction.sequence(actionsArray);
        
        scene.obstaclesNode!.run(actionSeq)
        scene.breakablesNode!.run(actionSeq)
        scene.player!.run(actionSeq)
        scene.bombsNode.run(actionSeq)
        scene.enemyNode!.run(actionSeq)
        scene.explosionsNode!.run(actionSeq)

    }
    
}
