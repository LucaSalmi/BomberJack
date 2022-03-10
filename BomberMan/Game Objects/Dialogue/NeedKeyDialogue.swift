//
//  NeedBombsDialogue.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-02-28.
//

import Foundation
import GameplayKit

class NeedKeyDialogue: Dialogue {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init() {
        
        var dialogueLines = [String]()
        
        dialogueLines.append("This door is locked.")
        dialogueLines.append("Where is the key?")
        
        super.init(dialogueLines: dialogueLines)
        
    }
    

}
