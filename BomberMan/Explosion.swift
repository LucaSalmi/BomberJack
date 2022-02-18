//
//  Explosion.swift
//  BomberMan
//
//  Created by Luca Salmi on 2022-02-18.
//

import Foundation
import SpriteKit

enum ExplosionSettings{
    
    static var range: Int = 1
    static var size: Int = 5
    static var distancePos: CGFloat = 32
    static var distanceNeg: CGFloat = -32
    static var permanence: Int = 60
    static var explosionsArray: [Explosion] = []
}

class Explosion: SKSpriteNode{
    
    var count: Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(position: CGPoint){
        
        let texture = SKTexture(imageNamed: "explosion1")
        let size: CGSize = CGSize(width: 32.0, height: 32.0)
        super.init(texture: texture, color: .white, size: size)
        self.position = position
    }
    
    func update(){
       
        count += 1
        
        if count >= ExplosionSettings.permanence{
            count = 0
            self.removeFromParent()
        }
    }
    
    
    
}
