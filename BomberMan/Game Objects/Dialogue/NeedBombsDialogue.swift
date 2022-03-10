//
//  NeedBombsDialogue.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-02-28.
//

import Foundation
import GameplayKit

class NeedBombsDialogue: Dialogue {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init() {
        
        var dialogueLines = [String]()
        
        dialogueLines.append("I need bombs to unblock this path!")
        
        super.init(dialogueLines: dialogueLines)
        
    }
    

}
