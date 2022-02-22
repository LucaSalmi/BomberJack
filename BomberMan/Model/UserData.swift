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

struct DefaultKeys{
    
    static let enemyKillsKey = "enemiesKilled"
    static let bombsDroppedKey = "bombsDropped"
    static let numbOfDeathsKey = "numberOfDeaths"
    static let barrelUsedKey = "barrelUsed"
}

class dataReaderWriter{
    
    static func saveUserData(){
        
        let defaultData = UserDefaults.standard
        defaultData.set(UserData.enemiesKilled, forKey: DefaultKeys.enemyKillsKey)
        defaultData.set(UserData.bombsDropped, forKey: DefaultKeys.bombsDroppedKey)
        defaultData.set(UserData.numberOfDeaths, forKey: DefaultKeys.numbOfDeathsKey)
        defaultData.set(UserData.barrelUsed, forKey: DefaultKeys.barrelUsedKey)
        print("data enemies: \(UserData.enemiesKilled)")
        print("data bombs: \(UserData.bombsDropped)")
        print("data deaths: \(UserData.numberOfDeaths)")
        print("data barrel: \(UserData.barrelUsed)")
    }
    
    static func loaduserData(){
        
        let defaultData = UserDefaults.standard
        UserData.enemiesKilled = defaultData.integer(forKey: DefaultKeys.enemyKillsKey)
        UserData.bombsDropped = defaultData.integer(forKey: DefaultKeys.bombsDroppedKey)
        UserData.numberOfDeaths = defaultData.integer(forKey: DefaultKeys.numbOfDeathsKey)
        UserData.barrelUsed = defaultData.integer(forKey: DefaultKeys.barrelUsedKey)
        print("data enemies: \(UserData.enemiesKilled)")
        print("data bombs: \(UserData.bombsDropped)")
        print("data deaths: \(UserData.numberOfDeaths)")
        print("data barrel: \(UserData.barrelUsed)")
    }
    
}


