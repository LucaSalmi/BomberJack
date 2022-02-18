//
//  Animatable.swift
//  BomberMan
//
//  Created by Luca Salmi on 2022-02-18.
//

import Foundation
import SpriteKit

protocol Animatable: AnyObject{
    
    var animations: [SKAction] {get set}
    
}

extension Animatable{
        
    func animationDirection(for directionVector: CGVector) -> Direction{
      let direction: Direction
      if abs(directionVector.dy) > abs(directionVector.dx){
        direction = directionVector.dy < 0 ? .forward : .backward
      }else{
        direction = directionVector.dx < 0 ? .left : .right
      }
      return direction
    }
    
    func createAnimations(character: String){
        
        let animOne: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_right_1"), SKTexture(pixelImageNamed: "\(character)_right_2")], timePerFrame: 0.4)
        let animTwo: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_right_2"), SKTexture(pixelImageNamed: "\(character)_right_3")], timePerFrame: 0.4)
        let animThree: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_right_3"), SKTexture(pixelImageNamed: "\(character)_right_4")], timePerFrame: 0.4)
        let animFour: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_right_5"), SKTexture(pixelImageNamed: "\(character)_right_6")], timePerFrame: 0.4)
        let animFive: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_right_7"), SKTexture(pixelImageNamed: "\(character)_right_1")], timePerFrame: 0.4)
        
        animations.append(animOne)
        animations.append(animTwo)
        animations.append(animThree)
        animations.append(animFour)
        animations.append(animFive)

        
        //let animationSet: SKAction = SKAction.animate(with: [SKTexture(pixelImageNamed: "\(character)_2"), SKTexture(pixelImageNamed: "\(character)_3"), SKTexture(pixelImageNamed: "\(character)_4"), SKTexture(pixelImageNamed: "\(character)_5"), SKTexture(pixelImageNamed: "\(character)_6"), SKTexture(pixelImageNamed: "\(character)_7")], timePerFrame: 0.2)
        //animations.append(animationSet)
        
    }
}
