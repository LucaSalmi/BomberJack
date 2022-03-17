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
            
            VStack(alignment: .leading){
                
                //ROW 1
                HStack{
                    
                    let level2ButtonID = 2
                    if level2ButtonID <= UserData.lastSavedLevel {
                        //Level 2 Button
                        LevelButtonView(buttonID: level2ButtonID, startGame: $startGame)
                            .opacity(!WorldMapAnimation.instance.isAnimating || UserData.lastSavedLevel > level2ButtonID ? 1 : 0)
                    }
                    
                    
                    let level3ButtonID = 3
                    if level3ButtonID <= UserData.lastSavedLevel {
                        //Level 3 Button
                        LevelButtonView(buttonID: level3ButtonID, startGame: $startGame)
                            .opacity(!WorldMapAnimation.instance.isAnimating || UserData.lastSavedLevel > level3ButtonID ? 1 : 0)
                            .padding(.leading, 80)
                    }
                }
                .padding(.leading, 30)
                .padding(.bottom, 40)
                
                //ROW 3
                HStack{
                    
                    let level1ButtonID = 1
                    if level1ButtonID <= UserData.lastSavedLevel {
                        //Level 1 Button
                        LevelButtonView(buttonID: level1ButtonID, startGame: $startGame)
                            .opacity(!WorldMapAnimation.instance.isAnimating || UserData.lastSavedLevel > level1ButtonID ? 1 : 0)
                    }
                    
                    let level4ButtonID = 4
                    if level4ButtonID <= UserData.lastSavedLevel {
                        //Level 4 Button
                        LevelButtonView(buttonID: level4ButtonID, startGame: $startGame)
                            .opacity(!WorldMapAnimation.instance.isAnimating || UserData.lastSavedLevel > level4ButtonID  ? 1 : 0)
                            .padding(.bottom, 10)
                            .padding(.leading, 200)
                    }
                    
                    
                    
                }
                .padding(.top, 40)
            }
            .padding(.leading, 170
        )
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
        .foregroundColor(Color.white)
        .shadow(color: .black, radius: 5)
        .font(.custom("Chalkduster", size: 18))
        .font(Font.body.bold())
        .font(.largeTitle)
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
