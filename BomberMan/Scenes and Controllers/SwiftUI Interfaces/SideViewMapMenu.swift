//
//  SideViewMapMenu.swift
//  BomberMan
//
//  Created by Hampus Brandtman on 2022-03-01.
//

import SwiftUI
import CoreData

struct SideViewMapMenu: View {
        
    @Binding var startGame: Bool
    
    var body: some View {
        
        VStack{
            
            Spacer()
            
            VStack{
                
                HStack(spacing: 150){
                    
                    
                    Button {
                        
                        print("level 1 pressed")
                        
                        
                        withAnimation(.easeIn(duration: 0.3)){
                                                        
                            if checkAndStartLevel(id: 1){
                                
                                startGame = true
                            }
                        }
                        
                    } label: {
                        Text("level 1")
                    }
                    .foregroundColor(.white)
                    .font(Font.body.bold())
                    .font(.largeTitle)
                    .padding(.leading, 100)
                    
                    Button {
                        
                        print("level 3 pressed")
                        
                        if checkAndStartLevel(id: 3){
                            
                            startGame = true
                        }
                        
                    } label: {
                        Text("level 3")
                    }
                    .foregroundColor(.white)
                    .font(Font.body.bold())
                    .font(.largeTitle)
                    
                    Button {
                        
                        print("level 5 pressed")
                        
                        if checkAndStartLevel(id: 5){
                            
                            startGame = true
                        }
                        
                    } label: {
                        Text("level 5")
                    }
                    .foregroundColor(.white)
                    .font(Font.body.bold())
                    .font(.largeTitle)
                    
                }
                .padding(40)
                .padding(.horizontal, 60)
                
                
                
                HStack(spacing: 150){
                    Button {
                        
                        print("level 2 pressed")
                        
                        if checkAndStartLevel(id: 2){
                            
                            startGame = true
                        }
                        
                    } label: {
                        Text("level 2")
                        
                        
                    }
                    .foregroundColor(.white)
                    .font(Font.body.bold())
                    .font(.largeTitle)
                    .padding(.leading, 100)
                    
                    Button {
                        
                        print("level 4 pressed")
                        
                        if checkAndStartLevel(id: 4){
                            
                            startGame = true
                        }
                        
                    } label: {
                        Text("level 4")
                    }
                    .foregroundColor(.white)
                    .font(Font.body.bold())
                    .font(.largeTitle)
                    
                    Button {
                        
                        print("level 6 pressed")
                        
                        if checkAndStartLevel(id: 6){
                            
                            startGame = true
                        }
                        
                    } label: {
                        Text("level 6")
                    }
                    .foregroundColor(.white)
                    .font(Font.body.bold())
                    .font(.largeTitle)
                    
                }
                .padding(40)
                .padding(.horizontal, 60)
            }
            Spacer()
            
        }
        .scaledToFill()
        .foregroundColor(.white)
        .background(Image("MapRoll").resizable().scaledToFit())
        
        .edgesIgnoringSafeArea(.trailing)
    }
    
    func checkAndStartLevel(id: Int) -> Bool{
        
        print(UserData.currentLevel)
        
        if UserData.currentLevel == id{
            
            return true
            
        }else if UserData.currentLevel > id{
            
            UserData.currentLevel = id
            return true
            
        }else if UserData.currentLevel < id && UserData.lastSavedLevel >= id{
            
            UserData.currentLevel = id
            return true
        }
        
        return false
    }

}
