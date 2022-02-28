//
//  needBombsEvent.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-02-28.
//

import Foundation
import GameplayKit

class NeedBombsEvent: Event {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init() {
        
        super.init(.white, (GameScene.tileSize)!)
        eventType = "needBombsEvent"
        zPosition = 50
    }
    
    override func collision(node: SKNode?) {
        
        super.collision(node: node)
        triggerEvent()
        
    }
    
    override func triggerEvent() {
        
        //Unique logarithm for this event goes here
        GameViewController.currentGameScene?.currentDialogue = NeedBombsDialogue()
        
    }
    
}
