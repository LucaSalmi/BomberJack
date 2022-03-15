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
                    
                    let lineWidth: CGFloat = 40
                    let lineHeight: CGFloat = 1.5
                    let lineColor: Color = Color.black
                    
                    //Level 2 Button
                    LevelButtonView(buttonID: 2, startGame: $startGame)
                        .opacity(!WorldMapAnimation.instance.isAnimating || UserData.lastSavedLevel > 2 ? 1 : 0)
                    
                    Rectangle()
                        .fill(lineColor)
                        .frame(width: lineWidth, height: lineHeight)
                        .opacity(0)
                    
                    //Level 3 Button
                    LevelButtonView(buttonID: 3, startGame: $startGame)
                        .opacity(!WorldMapAnimation.instance.isAnimating || UserData.lastSavedLevel > 3 ? 1 : 0)
                    
                    Rectangle()
                        .fill(lineColor)
                        .frame(width: lineWidth, height: lineHeight)
                        .opacity(0)
                    
                    //Level 6 Button
                    LevelButtonView(buttonID: 6, startGame: $startGame)
                        .opacity(!WorldMapAnimation.instance.isAnimating || UserData.lastSavedLevel > 6 ? 1 : 0)
                    
                }
                .padding(20)
                .padding(.horizontal, 60)
                
                //ROW 2 (only connecting lines)
                HStack() {
                    
                    let lineWidth: CGFloat = 1.5
                    let lineHeight: CGFloat = 50
                    let lineColor: Color = Color.black
                    
                    Rectangle()
                        .fill(lineColor)
                        .frame(width: lineWidth, height: lineHeight)
                        .padding(.leading, 90)
                        .opacity(0)
                    
                    Rectangle()
                        .fill(lineColor)
                        .frame(width: lineWidth, height: lineHeight)
                        .padding(.leading, 140)
                        .opacity(0)
                    
                    Rectangle()
                        .fill(lineColor)
                        .frame(width: lineWidth, height: lineHeight)
                        .padding(.leading, 140)
                        .opacity(0)
                    
                }
                
                //ROW 3
                HStack(){
                    
                    let lineWidth: CGFloat = 40
                    let lineHeight: CGFloat = 1.5
                    let lineColor: Color = Color.black
                    
                    //Level 1 Button
                    LevelButtonView(buttonID: 1, startGame: $startGame)
                        .opacity(!WorldMapAnimation.instance.isAnimating || UserData.lastSavedLevel > 1 ? 1 : 0)
                    
                    Rectangle()
                        .fill(lineColor)
                        .frame(width: lineWidth, height: lineHeight)
                        .opacity(0)
                    
                    //Level 4 Button
                    LevelButtonView(buttonID: 4, startGame: $startGame)
                        .opacity(!WorldMapAnimation.instance.isAnimating || UserData.lastSavedLevel > 4 ? 1 : 0)
                    
                    Rectangle()
                        .fill(lineColor)
                        .frame(width: lineWidth, height: lineHeight)
                        .opacity(0)
                    
                    //Level 5 Button
                    LevelButtonView(buttonID: 5, startGame: $startGame)
                        .opacity(!WorldMapAnimation.instance.isAnimating || UserData.lastSavedLevel > 5 ? 1 : 0)
                    
                }
                .padding(20)
                .padding(.horizontal, 60)
            }
            .padding(35)
            Spacer()
            
        }
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
        .opacity(checkAndStartLevel(id: buttonID) ? 1 : 0)
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
