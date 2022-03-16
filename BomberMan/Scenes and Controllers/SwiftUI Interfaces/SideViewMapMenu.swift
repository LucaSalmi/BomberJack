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
    
    @ObservedObject var worldMapAnimation = WorldMapAnimation.instance
    
    var body: some View {
        
        VStack{
            
            Spacer()
            
            VStack{
                
                //ROW 1
                HStack(){
                    
                    //Level 2 Button
                    LevelButtonView(buttonID: 2, startGame: $startGame)
                        .opacity(!WorldMapAnimation.instance.isAnimating || UserData.lastSavedLevel > 2 ? 1 : 0)
                        .padding(.leading, 175)
                    
                    //Level 3 Button
                    LevelButtonView(buttonID: 3, startGame: $startGame)
                        .opacity(!WorldMapAnimation.instance.isAnimating || UserData.lastSavedLevel > 3 ? 1 : 0)
                        .padding(.leading, 75)
                    
                    
                }
                .padding(10)
                
                //ROW 3
                HStack(){
                    
                    //Level 1 Button
                    LevelButtonView(buttonID: 1, startGame: $startGame)
                        .opacity(!WorldMapAnimation.instance.isAnimating || UserData.lastSavedLevel > 1 ? 1 : 0)
                        .padding(.leading, 100)
                    
                    //Level 4 Button
                    LevelButtonView(buttonID: 4, startGame: $startGame)
                        .opacity(!WorldMapAnimation.instance.isAnimating || UserData.lastSavedLevel > 4 ? 1 : 0)
                        .padding(.leading, 175)
                    
                }
                .padding(40)
            }
            .padding(25)
            Spacer()
            
        }
        .frame(width: 700, height: 500, alignment: .leading)
        .scaledToFill()
        .foregroundColor(.white)
        .background(Image(WorldMapAnimation.worldMapImageNames[worldMapAnimation.currentFrameIndex]).resizable().scaledToFit())
        .edgesIgnoringSafeArea(.trailing)
        .onAppear(perform: {
            worldMapAnimation.animateWorldMap()
        })
    }

}

struct LevelButtonView: View {
    
    let buttonID: Int
    @Binding var startGame: Bool
    
    var body: some View {
        Button {
            
            print("level \(buttonID) pressed")
            
            if checkAndStartLevel(id: buttonID){
                
                startGame = true
            }
            
        } label: {
            Text("level \(buttonID)")
        }
        .foregroundColor(.white)
        .font(Font.body.bold())
        .font(.largeTitle)
        .padding(.leading, 20)
        .opacity(checkLevelButton(id: buttonID) ? 1 : 0)
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
    
    func checkLevelButton(id: Int) -> Bool{

            if id <= UserData.lastSavedLevel+1{

                return true

            }
            return false
    }
    
}
