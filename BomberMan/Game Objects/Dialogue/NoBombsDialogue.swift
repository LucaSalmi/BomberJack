//
//  NeedBombsDialogue.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-03-15.
//

import Foundation
import GameplayKit

class NoBombsDialogue: Dialogue {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init() {
        
        var dialogueLines = [String]()
        
        dialogueLines.append("I have lost my precious bombs.")
        dialogueLines.append("Need to find 'em...")
        
        super.init(dialogueLines: dialogueLines)
        
    }
    

}
