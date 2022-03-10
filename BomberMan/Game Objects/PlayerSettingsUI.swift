//
//  PlayerSettings.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-03-10.
//

import Foundation
import GameplayKit

class PlayerSettingsUI: ObservableObject {
    
    static let instance = PlayerSettingsUI()
    
    @Published var haveBombs: Bool = false
    @Published var amountOfKeys = 0
    
    private init() {
        //SINGLETON. PRIVATE INIT.
    }
    
}
