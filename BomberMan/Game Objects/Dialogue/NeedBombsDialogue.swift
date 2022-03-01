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
        
        let dialogueText: String = "I need bombs to unblock this path!"
        super.init(dialogueText: dialogueText)
        
    }
    

}
