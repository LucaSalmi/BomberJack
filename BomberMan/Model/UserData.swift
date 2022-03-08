//
//  UserData.swift
//  BomberMan
//
//  Created by Luca Salmi on 2022-02-22.
//

import Foundation
import CoreData

enum UserData{
    
    //Inventory
    static var standardBombsAmmo: Int = 0
    static var trapBombsAmmo: Int = 0
    
    // Temporary start variable
    static var startGame: Bool = false
    
    //Playable Charachter
    static var lives: Int = 3
    static var currentLevel: Int = 0
    static var score: Int = 0
    
    //Stats
    static var enemiesKilled: Int64 = 0
    static var bombsDropped: Int64 = 0
    static var numberOfDeaths: Int64 = 0
    static var barrelUsed: Int64 = 0
    
}

struct DefaultKeys{
    
    static let musicToggleKey = "isMusicOn"
    static let sFXToggleKey = "areSFXOn"
    static let screenShakeToggleKey = "isScreenShakeOn"
}

class dataReaderWriter{
    
    static func saveUserData(){
        
        let defaultData = UserDefaults.standard
        defaultData.set(Options.options.isMusicOn, forKey: DefaultKeys.musicToggleKey)
        defaultData.set(Options.options.areSFXOn, forKey: DefaultKeys.sFXToggleKey)
        defaultData.set(Options.options.isScreenShakeOn, forKey: DefaultKeys.screenShakeToggleKey)

       
    }
    
    static func loaduserData(){
        
        let defaultData = UserDefaults.standard
        Options.options.isMusicOn = defaultData.bool(forKey: DefaultKeys.musicToggleKey)
        Options.options.areSFXOn = defaultData.bool(forKey: DefaultKeys.sFXToggleKey)
        Options.options.isScreenShakeOn = defaultData.bool(forKey: DefaultKeys.screenShakeToggleKey)

    }
    
    static func updateDatabase(){
        
        let viewContext = PersistenceController.shared.container.viewContext
        
        let fetchRequest = NSFetchRequest<Statistics>(entityName: "Statistics")
        
        do{
            let result = try viewContext.fetch(fetchRequest)
            let statistics = result[0]
            //update data in Database
            statistics.killedEnemies += UserData.enemiesKilled
            statistics.bombsDropped += UserData.bombsDropped
            statistics.numberOfDeaths += UserData.numberOfDeaths
            statistics.usedBarrel += UserData.barrelUsed
            //reset local data
            UserData.enemiesKilled = 0
            UserData.bombsDropped = 0
            UserData.numberOfDeaths = 0
            UserData.barrelUsed = 0
        
        }catch{
            print("result error")
            
        }
    }
}

class Options: ObservableObject{
        
    @Published var isMusicOn = true
    @Published var areSFXOn = true
    @Published var isScreenShakeOn = true
    
    static let options = Options()
    
    init(){}
    
}




