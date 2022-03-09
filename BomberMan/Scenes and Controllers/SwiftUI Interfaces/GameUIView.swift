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
    @Binding var isDead: Bool
    
    var body: some View {
        
        
        HStack {
            
            if !isPaused {
                
                Spacer()
                
                VStack {
                    HStack{
                        
                        Spacer()
                        
                        Button(action: {
                            
                            GameScene.gameState = .pause
                            
                            
                            withAnimation(.easeIn(duration: 0.4)){
                                isPaused = true
                            }
                            
                            
                        }, label: {
                            
                            HStack {
                                
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: 10, height: 40)
                                    .border(Color.black, width: 1)
                                
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: 10, height: 40)
                                    .border(Color.black, width: 1)
                                
                            }
                        })
                            .padding(20)
                    }
                    
                    
                    Spacer()
                    
                    HStack{
                        
                        Spacer()
                        
                        Button(action: {
                            if GameViewController.currentGameScene?.actionManager != nil {
                                GameViewController.currentGameScene?.actionManager.handleInput(id: MyViewSettings.actionShield, isPaused: isPaused)
                            }
                        }, label: {
                            Image("barrel_shield")
                                .resizable()
                                .frame(width: 35, height: 50, alignment: .center)
                            
                        })
                            .padding(20)
                        
                        
                    }
                    
                    HStack{
                        
                        Spacer()
                        Button(action: {
                            if GameViewController.currentGameScene?.actionManager != nil {
                                GameViewController.currentGameScene?.actionManager.handleInput(id: MyViewSettings.actionTrap, isPaused: isPaused)
                            }
                        }, label: {
                            Image("trap_bomb_flat")
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .center)
                        })
                            .padding(20)
                        
                        Button(action: {
                            if GameViewController.currentGameScene?.actionManager != nil {
                                GameViewController.currentGameScene?.actionManager.handleInput(id: MyViewSettings.actionDefaultBomb, isPaused: isPaused)
                            }
                        }, label: {
                            Image("bomb")
                                .resizable()
                                .frame(width: 55, height: 50, alignment: .center)
                        })
                            .padding(20)
                        
                    }
                }
            }
        }
    }
}

struct PauseMenu: View {
    
    @Binding var startGame: Bool
    @Binding var isPaused: Bool
    @Binding var isDead: Bool
    
    var body: some View {
        
        ZStack {
            
            let cornerRadius = CGFloat(10)
            let borderWidth = CGFloat(2)
            
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .foregroundColor(.gray)
                .frame(width: 300, height: 200)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(Color.white, lineWidth: borderWidth)
                )
            
            
            VStack {
                
                if isPaused {
                
                Button(action: {
                    if GameViewController.currentGameScene?.actionManager != nil {
                        withAnimation(.easeOut(duration: 0.3)){
                            isPaused = false
                        }
                        
                        GameScene.gameState = .play
                    }
                }, label: {
                    
                    Label("Continue", systemImage: "arrowtriangle.right.circle")
                        .foregroundColor(Color.white)
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.white, lineWidth: 1))
                
                    
                    
                })
                
                    .background(Color.black)
                    .cornerRadius(5)
                    
                }
                if isDead{
                    
                    
                    
                    Button(action: {
                        if GameViewController.currentGameScene?.actionManager != nil {
                            withAnimation(.easeOut(duration: 0.3)){
                                isPaused = false
                            }
                            
                            GameScene.gameState = .play
                        }
                    }, label: {
                        
                        Label("Restart", systemImage: "arrowtriangle.right.circle")
                            .foregroundColor(Color.white)
                            .padding(10)
                            .overlay(RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.white, lineWidth: 1))
                    
                        
                        
                    })
                    
                        .background(Color.black)
                        .cornerRadius(5)
                        
                    }
                
                
                
                
                Button(action: {
                    if GameViewController.currentGameScene?.actionManager != nil {
                        isPaused = false
                        GameScene.gameState = .play
                        GameViewController.currentGameScene?.actionManager.handleInput(id: MyViewSettings.actionNextLevel, isPaused: isPaused)
                    }
                }, label: {
                    
                    Label("Next Level", systemImage: "arrowshape.turn.up.right")
                        .foregroundColor(Color.white)
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.white, lineWidth: 1))
                })
                    .background(Color.black)
                    .cornerRadius(5)
                    .padding([.top, .bottom], 20)
                
                Button(action: {
                    startGame = false
                    isPaused = false
                    GameScene.gameState = .play
                    GameViewController.currentGameScene?.player?.resetInventory()
                    dataReaderWriter.updateDatabase()
                }, label: {
                    
                    Label("Main Menu", systemImage: "house")
                        .foregroundColor(Color.white)
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.white, lineWidth: 1))
                    
                    
                })
                    .background(Color.black)
                    .cornerRadius(5)
                
            }
        }
    }
}
