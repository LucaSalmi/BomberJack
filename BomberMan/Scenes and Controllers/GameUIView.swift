//
//  GameUIView.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-03-01.
//

import UIKit
import SwiftUI
import SpriteKit
import GameplayKit

struct GameUIView: View {
    
    @Binding var startGame: Bool
    @Binding var isPaused: Bool
    
    var body: some View {
        
        HStack {
            Spacer()
            VStack {
                
                Button(action: {
                    isPaused = true
                    GameScene.gameState = .pause
                }, label: {
                    
                    HStack {
                        
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 10, height: 40)
                            .border(Color.black, width: 2)
                        
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 10, height: 40)
                            .border(Color.black, width: 2)
                        
                    }
                    
//                    Text("Pause")
//                        .foregroundColor(.black)
//                        .padding(8)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 5)
//                                .stroke(Color.black, lineWidth: 1)
//                        )
                       
                })
                    .padding([.top], 20)
                
                Spacer()
                
                Button(action: {
                    if GameViewController.currentGameScene?.actionManager != nil {
                        GameViewController.currentGameScene?.actionManager.handleInput(id: MyViewSettings.actionDefaultBomb, isPaused: isPaused)
                    }
                }, label: {
                    Image("bomb1")
                        .resizable()
                        .frame(width: 55, height: 50, alignment: .center)
                })
                    .padding([.top], 20)
                    
                Button(action: {
                    if GameViewController.currentGameScene?.actionManager != nil {
                        GameViewController.currentGameScene?.actionManager.handleInput(id: MyViewSettings.actionTrap, isPaused: isPaused)
                    }
                }, label: {
                    Image("trap")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                })
                    .padding([.top], 20)
                Button(action: {
                    if GameViewController.currentGameScene?.actionManager != nil {
                        GameViewController.currentGameScene?.actionManager.handleInput(id: MyViewSettings.actionShield, isPaused: isPaused)
                    }
                }, label: {
                    Image("barrel_shield")
                        .resizable()
                        .frame(width: 35, height: 50, alignment: .center)
                })
                    .padding([.top], 20)
                
                    
            }
        }
        
    }
    
}

struct PauseMenu: View {
    
    @Binding var startGame: Bool
    @Binding var isPaused: Bool
    
    var body: some View {
        
        ZStack {
        
            let cornerRadius = CGFloat(10)
            let frameWidth = CGFloat(500)
            let frameHeight = CGFloat(200)
            let borderWidth = CGFloat(4)
            
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .foregroundColor(.white)
                .frame(width: frameWidth, height: frameHeight)
            
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .foregroundColor(.black)
                .frame(width: frameWidth-borderWidth, height: frameHeight-borderWidth)
         
            VStack {
                
                Button(action: {
                    if GameViewController.currentGameScene?.actionManager != nil {
                        isPaused = false
                        GameScene.gameState = .play
                    }
                }, label: {
                    Text("Continue")
                        .foregroundColor(.white)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.white, lineWidth: 1)
                        )
                })
                
                Button(action: {
                    if GameViewController.currentGameScene?.actionManager != nil {
                        isPaused = false
                        GameScene.gameState = .play
                        GameViewController.currentGameScene?.actionManager.handleInput(id: MyViewSettings.actionNextLevel, isPaused: isPaused)
                    }
                }, label: {
                    Text("Next Level")
                        .foregroundColor(.white)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.white, lineWidth: 1)
                        )
                })
                    .padding([.top, .bottom], 20)
                
                Button(action: {
                    startGame = false
                    isPaused = false
                }, label: {
                    Text("Main Menu")
                        .foregroundColor(.white)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.white, lineWidth: 1)
                                
                                
                        )
                })
                
            }
            
            
        }
    }
}
