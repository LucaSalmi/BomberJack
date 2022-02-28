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
    //let labelNode: SKLabelNode
    
    let dialogueText: String!
    let showingTime = 60 * 3
    var ticks: Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(dialogueText: String) {
        self.dialogueText = dialogueText
        self.shapeNode = SKShapeNode(rectOf: CGSize(width: 400, height: 200), cornerRadius: 10.0)
        //self.labelNode = SKLabelNode()
        super.init()
        setupShapeNode()
        //setupLabelNode()
        zPosition = 100
    }
    
    private func setupShapeNode() {
        shapeNode.fillColor = .black
        addChild(shapeNode)
    }
    
    private func setupLabelNode() {
        //labelNode.text = dialogueText
        //labelNode.fontSize = 24
        //labelNode.fontColor = .black
        //addChild(labelNode)
    }
    
    func update() {
        
        if let player = GameViewController.currentGameScene?.player {
            position = player.position
            shapeNode.position = position
            //labelNode.position = position
        }
        
        ticks += 1
        if ticks >= showingTime {
            GameViewController.currentGameScene?.currentDialogue = nil
            self.removeFromParent()
        }
        
    }
    
}
