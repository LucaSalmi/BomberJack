//
//  Enemy.swift
//  BomberMan
//
//  Created by Luca Salmi, Daniel Falkedal, Calle Höglund, Hampus Brandtman on 2022-02-15.
//

import Foundation
import GameplayKit

class Enemy: SKSpriteNode {
    
    //Keep references to all enemies
    static var enemies = [Enemy]()

    var enemySpeed: CGFloat = 0.0
    
    var difficult: Int = 0
    
    //Constants
    let superEasy: Int = 0
    let easy: Int = 1
    let normal: Int = 2
    let hard: Int = 3
    let superHard: Int = 4
 
    func update() {
        //Override this in enemy subclasses
    }
    
}
