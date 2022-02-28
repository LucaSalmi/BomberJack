//
//  Dialogue.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-02-28.
//

import Foundation
import GameplayKit

class Dialogue: SKSpriteNode {
    
    let dialogueText: String!
    let showingTime = 60 * 3
    var ticks: Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(dialogueText: String) {
        self.dialogueText = dialogueText
        super.init(texture: SKTexture(imageNamed: "event"), color: .white, size: CGSize(width: 200, height: 200))
        zPosition = 150
    }
    
    func update() {
        
        ticks += 1
        if ticks >= showingTime {
            GameViewController.currentGameScene?.currentDialogue = nil
        }
        
        self.removeFromParent()
        
    }
    
}
