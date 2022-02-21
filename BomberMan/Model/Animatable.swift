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
    
}

extension Animatable{
    
    func createPlayerAnimations(character: String){
        
        let animROne: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_right_1"), SKTexture(pixelImageNamed: "\(character)_right_2")], timePerFrame: 0.4)
        let animRTwo: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_right_2"), SKTexture(pixelImageNamed: "\(character)_right_3")], timePerFrame: 0.4)
        let animRThree: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_right_3"), SKTexture(pixelImageNamed: "\(character)_right_4")], timePerFrame: 0.4)
        let animRFour: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_right_5"), SKTexture(pixelImageNamed: "\(character)_right_6")], timePerFrame: 0.4)
        let animRFive: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_right_7"), SKTexture(pixelImageNamed: "\(character)_right_1")], timePerFrame: 0.4)
        
        rightAnimations.append(animROne)
        rightAnimations.append(animRTwo)
        rightAnimations.append(animRThree)
        rightAnimations.append(animRFour)
        rightAnimations.append(animRFive)
        
        let animLOne: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_left_1"), SKTexture(pixelImageNamed: "\(character)_left_2")], timePerFrame: 0.4)
        let animLTwo: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_left_2"), SKTexture(pixelImageNamed: "\(character)_left_3")], timePerFrame: 0.4)
        let animLThree: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_left_3"), SKTexture(pixelImageNamed: "\(character)_left_4")], timePerFrame: 0.4)
        let animLFour: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_left_5"), SKTexture(pixelImageNamed: "\(character)_left_6")], timePerFrame: 0.4)
        let animLFive: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_left_7"), SKTexture(pixelImageNamed: "\(character)_left_1")], timePerFrame: 0.4)
        
        leftAnimations.append(animLOne)
        leftAnimations.append(animLTwo)
        leftAnimations.append(animLThree)
        leftAnimations.append(animLFour)
        leftAnimations.append(animLFive)
        
    }
}
