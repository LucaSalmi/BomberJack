//
//  Dialogue.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-02-28.
//

import Foundation
import GameplayKit

enum DialogueSettings {
    
    static let defaultPositionOffsetY: CGFloat = 150
    static let cavePositionOffsetY: CGFloat = 75
    
    static let defaultFontSize: CGFloat = 26
    static let caveFontSize: CGFloat = 13
    
}

class Dialogue: SKNode {
    
    var shapeNode: SKShapeNode? = nil
    var labelNode: SKLabelNode? = nil
    
    let dialogueText: String!
    let showingTime = 60 * 3
    var ticks: Int = 0
    
    let positionOffsetY: CGFloat = 150
    let textPadding: CGFloat = 50
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(dialogueText: String) {
        
        self.dialogueText = dialogueText
        super.init()
        
        self.labelNode = SKLabelNode()
        setupLabelNode()
        let width = labelNode!.frame.width + textPadding
        let height = labelNode!.frame.height + textPadding
        self.shapeNode = SKShapeNode(rectOf: CGSize(width: width, height: height), cornerRadius: 10.0)
        setupShapeNode()
        
        if GameViewController.currentGameScene!.isCaveLevel {
            position.y += DialogueSettings.cavePositionOffsetY
        }
        else {
            position.y += DialogueSettings.defaultPositionOffsetY
        }
        
        zPosition = 70
    }
    
    private func setupShapeNode() {
        shapeNode!.fillColor = .black
        shapeNode!.alpha = 0.8
        shapeNode!.zPosition = 51
        addChild(shapeNode!)
    }
    
    private func setupLabelNode() {
        labelNode!.text = dialogueText
        labelNode!.fontColor = .white
        labelNode!.fontName = "Chalkduster"
        if GameViewController.currentGameScene!.isCaveLevel {
            labelNode!.fontSize = DialogueSettings.caveFontSize
        }
        else {
            labelNode!.fontSize = DialogueSettings.defaultFontSize
        }
        labelNode!.alpha = 1
        labelNode!.zPosition = 52
        addChild(labelNode!)
    }
    
    func update() {
        
        if let player = GameViewController.currentGameScene?.player {
            position = player.position
            if GameViewController.currentGameScene!.isCaveLevel {
                position.y += DialogueSettings.cavePositionOffsetY
            }
            else {
                position.y += DialogueSettings.defaultPositionOffsetY
            }
        }
        
        ticks += 1
        if ticks >= showingTime {
            GameViewController.currentGameScene?.currentDialogue = nil
            self.removeFromParent()
        }
        
    }
    
}

