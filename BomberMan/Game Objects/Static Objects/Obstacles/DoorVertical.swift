//
//  DoorVertical.swift
//  BomberMan
//
//  Created by Calle Höglund on 2022-03-03.
//

import Foundation
import SpriteKit

class DoorVertical: Door{
    
    override func collision(with other: SKNode?){
        
        if PlayerSettings.amountOfKeys > 0{
            super.collision(with: other)
            self.doorTexture.texture = SKTexture(imageNamed: "door_horizontal")
            
        }
    }
    
}
