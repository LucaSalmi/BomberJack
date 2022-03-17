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
    static let numberOfFramesRushEnemy = 12
    static let numberOfFramesClassicEnemy = 4
    static let timePerFramePlayer = 0.4
    static let timePerFrameRushEnemy = 0.4
    static let timePerFrameClassicEnemy = 0.4
}

protocol Animatable: AnyObject{
    
    var rightAnimations: [SKAction] {get set}
    var leftAnimations: [SKAction] {get set}
    var upAnimations: [SKAction] {get set}
    var downAnimations: [SKAction] {get set}
    
}

extension Animatable{
    
    
    func createAnimationSets(characterAnimationNames: [String], numberOfFrames: Int, timePerFrame: Double){
        
        for fileName in characterAnimationNames{
            
            for i in 1...numberOfFrames{
                
                let anim: SKAction
                
                if i == numberOfFrames{
                    //the last animation frame is connected to the first again
                    anim = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(fileName)\(i)"), SKTexture(pixelImageNamed: "\(fileName)1")], timePerFrame: timePerFrame)
                    
                }else{
                    //one frame is connected to the next in a SKAction
                    anim = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(fileName)\(i)"), SKTexture(pixelImageNamed: "\(fileName)\(i+1)")], timePerFrame: timePerFrame)
                    
                }
                
                switch fileName{
                    
                case characterAnimationNames[0]:
                    rightAnimations.append(anim)
                    
                case characterAnimationNames[1]:
                    leftAnimations.append(anim)
                    
                case characterAnimationNames[2]:
                    downAnimations.append(anim)
                    
                case characterAnimationNames[3]:
                    upAnimations.append(anim)
                    
                default:
                    print("animation error")
                }
            }
            
        }
        
    }
    
    func setRushEnemyAnimations(characterAnimationNames: [String]){
        
        
        for fileName in characterAnimationNames{
            
            if fileName == "rush_down_"{
                
                let actionBackward1: SKAction = SKAction.animate(with: [
                    SKTexture(imageNamed: "\(fileName)1"),
                    SKTexture(imageNamed: "\(fileName)2")
                ], timePerFrame: 0.4)
                downAnimations.append(actionBackward1)
                let actionBackward2: SKAction = SKAction.animate(with: [
                    SKTexture(imageNamed: "\(fileName)2"),
                    SKTexture(imageNamed: "\(fileName)1")
                ], timePerFrame: 0.4)
                downAnimations.append(actionBackward2)
                
            }else if fileName == "rush_top_"{
                
                let actionForward1: SKAction = SKAction.animate(with: [
                    SKTexture(imageNamed: "\(fileName)1"),
                    SKTexture(imageNamed: "\(fileName)2")
                ], timePerFrame: 0.4)
                upAnimations.append(actionForward1)
                let actionForward2: SKAction = SKAction.animate(with: [
                    SKTexture(imageNamed: "\(fileName)2"),
                    SKTexture(imageNamed: "\(fileName)1")
                ], timePerFrame: 0.4)
                upAnimations.append(actionForward2)
                
            }else{
                
                for i in 1...AnimationData.numberOfFramesRushEnemy{
                    
                    let anim: SKAction
                    
                    if i == AnimationData.numberOfFramesRushEnemy{
                        //the last animation frame is connected to the first again
                        anim = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(fileName)\(i)"), SKTexture(pixelImageNamed: "\(fileName)1")], timePerFrame: 0.4)
                        
                    }else{
                        //one frame is connected to the next in a SKAction
                        anim = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(fileName)\(i)"), SKTexture(pixelImageNamed: "\(fileName)\(i+1)")], timePerFrame: 0.4)
                        
                    }
                    
                    switch fileName{
                        
                    case "rush_right_":
                        rightAnimations.append(anim)
                        
                    case "rush_left_":
                        leftAnimations.append(anim)
                        
                    default:
                        print("animation error")
                    }
                }
            }
        }
    }
    
    
    
    
    
}
