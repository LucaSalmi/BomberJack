//
//  NeedBombsDialogue.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-03-09.
//

import Foundation
import GameplayKit

class Level1IntroDialogue: Dialogue {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init() {
        
        var dialogueLines = [String]()
        
        dialogueLines.append("Those filthy worms called a mutiny.")
        dialogueLines.append("Time for revenge!")
        
        super.init(dialogueLines: dialogueLines)
        
    }
    

}
