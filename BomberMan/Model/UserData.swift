//
//  UserData.swift
//  BomberMan
//
//  Created by Luca Salmi on 2022-02-22.
//

import Foundation

enum UserData{
    
    //Inventory
    static var standardBombsAmmo: Int = 0
    static var trapBombsAmmo: Int = 0
    
    //Playable Charachter
    static var lives: Int = 3
    static var currentLevel: Int = 0
    static var score: Int = 0
    
    //Stats
    static var enemiesKilled: Int = 0
    static var bombsDropped: Int = 0
    static var numberOfDeaths: Int = 0
    static var barrelUsed: Int = 0

    
}
