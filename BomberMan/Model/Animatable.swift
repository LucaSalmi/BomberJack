//
//  Animatable.swift
//  BomberMan
//
//  Created by Luca Salmi, Daniel Falkedal, Calle Höglund, Hampus Brandtman on 2022-02-18.
//

import Foundation
import SpriteKit

protocol Animatable: AnyObject{
    
    var rightAnimations: [SKAction] {get set}
    var leftAnimations: [SKAction] {get set}
    var upAnimations: [SKAction] {get set}
    var downAnimations: [SKAction] {get set}
    
}

extension Animatable{
    
    func createPlayerAnimations(character: String){
        
        let animROne: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_right_1"), SKTexture(pixelImageNamed: "\(character)_right_2")], timePerFrame: 0.4)
        let animRTwo: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_right_2"), SKTexture(pixelImageNamed: "\(character)_right_3")], timePerFrame: 0.4)
        let animRThree: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_right_3"), SKTexture(pixelImageNamed: "\(character)_right_4")], timePerFrame: 0.4)
        let animRFour: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_right_4"), SKTexture(pixelImageNamed: "\(character)_right_5")], timePerFrame: 0.4)
        let animRFive: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_right_5"), SKTexture(pixelImageNamed: "\(character)_right_6")], timePerFrame: 0.4)
        let animRSix: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_right_7"), SKTexture(pixelImageNamed: "\(character)_right_1")], timePerFrame: 0.4)
        
        rightAnimations.append(animROne)
        rightAnimations.append(animRTwo)
        rightAnimations.append(animRThree)
        rightAnimations.append(animRFour)
        rightAnimations.append(animRFive)
        rightAnimations.append(animRSix)
        
        let animLOne: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_left_1"), SKTexture(pixelImageNamed: "\(character)_left_2")], timePerFrame: 0.4)
        let animLTwo: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_left_2"), SKTexture(pixelImageNamed: "\(character)_left_3")], timePerFrame: 0.4)
        let animLThree: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_left_3"), SKTexture(pixelImageNamed: "\(character)_left_4")], timePerFrame: 0.4)
        let animLFour: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_left_4"), SKTexture(pixelImageNamed: "\(character)_left_5")], timePerFrame: 0.4)
        let animLFive: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_left_5"), SKTexture(pixelImageNamed: "\(character)_left_6")], timePerFrame: 0.4)
        let animLSix: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_left_7"), SKTexture(pixelImageNamed: "\(character)_left_1")], timePerFrame: 0.4)
        
        leftAnimations.append(animLOne)
        leftAnimations.append(animLTwo)
        leftAnimations.append(animLThree)
        leftAnimations.append(animLFour)
        leftAnimations.append(animLFive)
        leftAnimations.append(animLSix)
        
        let animUpOne: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_up_1"), SKTexture(pixelImageNamed: "\(character)_up_2")], timePerFrame: 0.4)
        let animUpTwo: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_up_2"), SKTexture(pixelImageNamed: "\(character)_up_3")], timePerFrame: 0.4)
        let animUpThree: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_up_3"), SKTexture(pixelImageNamed: "\(character)_up_4")], timePerFrame: 0.4)
        let animUpFour: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_up_4"), SKTexture(pixelImageNamed: "\(character)_up_5")], timePerFrame: 0.4)
        let animUpFive: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_up_5"), SKTexture(pixelImageNamed: "\(character)_up_6")], timePerFrame: 0.4)
        let animUpSix: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_up_7"), SKTexture(pixelImageNamed: "\(character)_up_1")], timePerFrame: 0.4)
        
        upAnimations.append(animUpOne)
        upAnimations.append(animUpTwo)
        upAnimations.append(animUpThree)
        upAnimations.append(animUpFour)
        upAnimations.append(animUpFive)
        upAnimations.append(animUpSix)
        
        let animDownOne: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_down_1"), SKTexture(pixelImageNamed: "\(character)_down_2")], timePerFrame: 0.4)
        let animDownTwo: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_down_2"), SKTexture(pixelImageNamed: "\(character)_down_3")], timePerFrame: 0.4)
        let animDownThree: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_down_3"), SKTexture(pixelImageNamed: "\(character)_down_4")], timePerFrame: 0.4)
        let animDownFour: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_down_4"), SKTexture(pixelImageNamed: "\(character)_down_5")], timePerFrame: 0.4)
        let animDownFive: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_down_5"), SKTexture(pixelImageNamed: "\(character)_down_6")], timePerFrame: 0.4)
        let animDownSix: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_down_7"), SKTexture(pixelImageNamed: "\(character)_down_1")], timePerFrame: 0.4)
        
        downAnimations.append(animDownOne)
        downAnimations.append(animDownTwo)
        downAnimations.append(animDownThree)
        downAnimations.append(animDownFour)
        downAnimations.append(animDownFive)
        downAnimations.append(animDownSix)
        
    }
}
