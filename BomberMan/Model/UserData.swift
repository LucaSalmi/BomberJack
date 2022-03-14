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
    static var currentLevel: Int = 1
    static var lastSavedLevel: Int = 0
    static let numberOfLevels: Int = 4
    
    //Stats
    static var enemiesKilled: Int64 = 0
    static var bombsDropped: Int64 = 0
    static var numberOfDeaths: Int64 = 0
    static var barrelUsed: Int64 = 0
    
}

struct DefaultKeys{
    
    static let defaultData = UserDefaults.standard
    static let musicToggleKey = "isMusicOn"
    static let sFXToggleKey = "areSFXOn"
    static let screenShakeToggleKey = "isScreenShakeOn"
    static let lastPlayedLevelKey = "lastCompletedLevel"
}

class dataReaderWriter{
    
    static func saveUserData(){
        
        DefaultKeys.defaultData.set(Options.options.isMusicOn, forKey: DefaultKeys.musicToggleKey)
        DefaultKeys.defaultData.set(Options.options.areSFXOn, forKey: DefaultKeys.sFXToggleKey)
        DefaultKeys.defaultData.set(Options.options.isScreenShakeOn, forKey: DefaultKeys.screenShakeToggleKey)

       
    }
    
    static func loaduserData(){
        
        Options.options.isMusicOn = DefaultKeys.defaultData.bool(forKey: DefaultKeys.musicToggleKey)
        Options.options.areSFXOn = DefaultKeys.defaultData.bool(forKey: DefaultKeys.sFXToggleKey)
        Options.options.isScreenShakeOn = DefaultKeys.defaultData.bool(forKey: DefaultKeys.screenShakeToggleKey)

    }
    
    static func saveLocalSaveData(){
        
        if UserData.currentLevel < UserData.lastSavedLevel{
            
            DefaultKeys.defaultData.set(UserData.lastSavedLevel, forKey: DefaultKeys.lastPlayedLevelKey)
            
        }else{
            
            DefaultKeys.defaultData.set(UserData.currentLevel, forKey: DefaultKeys.lastPlayedLevelKey)
        }
        
        
    }
    
    static func loadLocalSaveData(){
        
        UserData.currentLevel = DefaultKeys.defaultData.integer(forKey: DefaultKeys.lastPlayedLevelKey)
        UserData.lastSavedLevel = UserData.currentLevel
        
        if UserData.currentLevel == 0{
            UserData.currentLevel = 1
        }
        
    }
    
    
    
    static func updateDatabase(){
        
        let viewContext = PersistenceController.shared.container.viewContext
        
        let fetchRequest = NSFetchRequest<Statistics>(entityName: "Statistics")
        
        do{
            let result = try viewContext.fetch(fetchRequest)
            if result.isEmpty{
                return
            }
            let statistics = result[0]
            
            //update data in Database
            statistics.killedEnemies += UserData.enemiesKilled
            statistics.bombsDropped += UserData.bombsDropped
            statistics.numberOfDeaths += UserData.numberOfDeaths
            statistics.usedBarrel += UserData.barrelUsed
            
            let level = UserData.currentLevel - 1
            if level > statistics.lastCompletedLevel{
                
                statistics.lastCompletedLevel = Int64(level)
                
            }
            
            do {
                
                try viewContext.save()
                
            }catch{
                
                print("save error")
            }
                
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
    
    private init(){}
    
    //SINGLETON 
}




