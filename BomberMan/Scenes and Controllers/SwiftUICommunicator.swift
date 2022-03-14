//
//  SwiftUICommunicator.swift
//  BomberMan
//
//  Created by Calle Höglund on 2022-03-09.
//

import Foundation
import SwiftUI


class SwiftUICommunicator: ObservableObject {
    
    static let instance = SwiftUICommunicator()
    
    @Published var isGameOver = false
    
    private init() {
        //SINGLETON. PRIVATE INIT.
    }
    
    func setIsGameOver(){
        withAnimation{
            isGameOver = true
        }
        
    }
    
}
