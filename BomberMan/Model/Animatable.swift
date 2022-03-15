//
//  Animatable.swift
//  BomberMan
//
//  Created by Luca Salmi, Daniel Falkedal, Calle Höglund, Hampus Brandtman on 2022-02-18.
//

import Foundation
import SpriteKit

enum AnimationData{
    
    static let numberOfFramesPlayer = 7
    
}

protocol Animatable: AnyObject{
    
    var rightAnimations: [SKAction] {get set}
    var leftAnimations: [SKAction] {get set}
    var upAnimations: [SKAction] {get set}
    var downAnimations: [SKAction] {get set}
    
}

extension Animatable{
    
    
    func createPlayerAnimations(characterAnimationNames: [String]){
        
        for fileName in characterAnimationNames{
            
            for i in 1...AnimationData.numberOfFramesPlayer{
                
                let anim: SKAction
                
                if i == AnimationData.numberOfFramesPlayer{
                    //the last animation frame is connected to the first again
                    anim = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(fileName)\(i)"), SKTexture(pixelImageNamed: "\(fileName)1")], timePerFrame: 0.4)
                    
                }else{
                    //one frame is connected to the next in a SKAction
                    anim = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(fileName)\(i)"), SKTexture(pixelImageNamed: "\(fileName)\(i+1)")], timePerFrame: 0.4)
                    
                }
                
                switch fileName{
                    
                case "player_walk_right_":
                    rightAnimations.append(anim)
                    
                case "player_walk_left_":
                    leftAnimations.append(anim)
                    
                case "player_walk_up_":
                    upAnimations.append(anim)
                    
                case "player_walk_down_":
                    downAnimations.append(anim)
                                        
                default:
                    print("animation error")
                }
            }
            
        }
        
    }
    
    func setEnemyAnimations(enemy: String){
        
        let actionForward: SKAction = SKAction.animate(with: [
            SKTexture(imageNamed: "\(enemy)_up_1"),
            SKTexture(imageNamed: "\(enemy)_up_1")
        ], timePerFrame: 0.2)
        upAnimations.append(SKAction.repeatForever(actionForward))
        
        let actionBackward: SKAction = SKAction.animate(with: [
            SKTexture(imageNamed: "\(enemy)_down_1"),
            SKTexture(imageNamed: "\(enemy)_down_1")
        ], timePerFrame: 0.2)
        downAnimations.append(SKAction.repeatForever(actionBackward))
        
        let actionLeft: SKAction = SKAction.animate(with: [
            SKTexture(imageNamed: "\(enemy)_left_1"),
            SKTexture(imageNamed: "\(enemy)_left_1")
        ], timePerFrame: 0.2)
        leftAnimations.append(SKAction.repeatForever(actionLeft))
        
        let actionRight: SKAction = SKAction.animate(with: [
            SKTexture(imageNamed: "\(enemy)_right_1"),
            SKTexture(imageNamed: "\(enemy)_right_1")
        ], timePerFrame: 0.2)
        rightAnimations.append(SKAction.repeatForever(actionRight))
        
        
    }
    
    
}
