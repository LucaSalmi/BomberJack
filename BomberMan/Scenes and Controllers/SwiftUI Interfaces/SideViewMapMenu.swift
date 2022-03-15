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
                    
                    Button {
                        
                        print("level 2 pressed")
                        
                        
                        withAnimation(.easeIn(duration: 0.3)){
                                                        
                            if checkAndStartLevel(id: 2){
                                
                                startGame = true
                            }
                        }
                        
                    } label: {
                        Text("level 2")
                    }
                    .foregroundColor(.white)
                    .font(Font.body.bold())
                    .font(.largeTitle)
                    .padding(.leading, 75)
                    .padding(.trailing, 20)
                    .opacity(checkAndStartLevel(id: 2) ? 1 : 0)
                    
                    Rectangle()
                        .fill(lineColor)
                        .frame(width: lineWidth, height: lineHeight)
                        .opacity(0)
                    
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
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .opacity(checkAndStartLevel(id: 3) ? 1 : 0)
                    
                    Rectangle()
                        .fill(lineColor)
                        .frame(width: lineWidth, height: lineHeight)
                        .opacity(0)
                    
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
                    .padding(.leading, 20)
                    .opacity(checkAndStartLevel(id: 6) ? 1 : 0)
                    
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
                    
                    Button {
                        
                        print("level 1 pressed")
                        
                        if checkAndStartLevel(id: 1){
                            
                            startGame = true
                        }
                        
                    } label: {
                        Text("level 1")
                        
                        
                    }
                    .foregroundColor(.white)
                    .font(Font.body.bold())
                    .font(.largeTitle)
                    .padding(.leading, 75)
                    .padding(.trailing, 20)
                    .opacity(checkAndStartLevel(id: 1) ? 1 : 0)
                    
                    Rectangle()
                        .fill(lineColor)
                        .frame(width: lineWidth, height: lineHeight)
                        .opacity(0)
                    
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
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .opacity(checkAndStartLevel(id: 4) ? 1 : 0)
                    
                    Rectangle()
                        .fill(lineColor)
                        .frame(width: lineWidth, height: lineHeight)
                        .opacity(0)
                    
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
                    .padding(.leading, 20)
                    .opacity(checkAndStartLevel(id: 5) ? 1 : 0)
                    
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
