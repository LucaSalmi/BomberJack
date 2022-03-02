//
//  SideViewMapMenu.swift
//  BomberMan
//
//  Created by Hampus Brandtman on 2022-03-01.
//

import SwiftUI

struct SideViewMapMenu: View {
    
    @Binding var startGame: Bool
    
    var body: some View {
        VStack{
            
            Spacer()
            
            VStack{
                
                HStack(spacing: 150){
                    Button {
                    
                        print("level 1 pressed")
                        startGame = true
                        
                    } label: {
                        Text("level 1")
                    }
                    .foregroundColor(.white)
                    .font(Font.body.bold())
                    .font(.largeTitle)
                    
                    Button {
                    
                        print("level 3 pressed")
                        
                    } label: {
                        Text("level 3")
                    }
                    .foregroundColor(.white)
                    .font(Font.body.bold())
                    .font(.largeTitle)
                    
                    Button {
                    
                        print("level 5 pressed")
                        
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
                        
                    } label: {
                        Text("level 2")
                    }
                    .foregroundColor(.white)
                    .font(Font.body.bold())
                    .font(.largeTitle)
                    
                    Button {
                    
                        print("level 4 pressed")
                        
                    } label: {
                        Text("level 4")
                    }
                    .foregroundColor(.white)
                    .font(Font.body.bold())
                    .font(.largeTitle)
                    
                    Button {
                    
                        print("level 6 pressed")
                        
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
        .background(.black).opacity(0.5)
        .edgesIgnoringSafeArea(.trailing)
    }
}
