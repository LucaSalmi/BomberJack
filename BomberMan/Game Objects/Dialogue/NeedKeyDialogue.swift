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
        
        let dialogueText: String = "This door is locked. Where is the key?"
        super.init(dialogueText: dialogueText)
        
    }
    

}
