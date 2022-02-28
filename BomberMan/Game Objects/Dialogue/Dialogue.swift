//
//  Dialogue.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-02-28.
//

import Foundation
import GameplayKit

class Dialogue: SKNode {
    
    let shapeNode: SKShapeNode
    
    let dialogueText: String!
    let showingTime = 60 * 3
    var ticks: Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(dialogueText: String) {
        self.shapeNode = SKShapeNode(rectOf: CGSize(width: 400, height: 200), cornerRadius: 10.0)
        self.dialogueText = dialogueText
        super.init()
        setupShapeNode()
        zPosition = 100
    }
    
    private func setupShapeNode() {
        shapeNode.fillColor = .black
        shapeNode.alpha = 0.5
        addChild(shapeNode)
    }
    
    func update() {
        
        if let player = GameViewController.currentGameScene?.player {
            position = player.position
        }
        
        ticks += 1
        if ticks >= showingTime {
            GameViewController.currentGameScene?.currentDialogue = nil
            self.removeFromParent()
        }
        
    }
    
}
