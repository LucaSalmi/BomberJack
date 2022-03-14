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
    
    @ObservedObject var swiftUICommunicator = SwiftUICommunicator.instance
    @ObservedObject var playerSettingsUI = PlayerSettingsUI.instance
    
    var body: some View {
        
        
        HStack {
            
            if !isPaused && !swiftUICommunicator.isGameOver {
                
                //LEFT SIDE UI (INVENTORY DATA)
                VStack {
                    
                    HStack {
                        Image("KeyOneLoot")
                            .resizable()
                            .frame(width: 35, height: 35, alignment: .center)
                        
                        Text("\(playerSettingsUI.amountOfKeys)")
                            .font(.custom("Chalkduster", size: 22))
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 16)
                    
                    Spacer()
                    
                }
                
                Spacer()
                
                //RIGHT SIDE UI (BUTTONS)
                VStack {
                    HStack{
                        
                        Spacer()
                        
                        Button(action: {
                            
                            GameScene.gameState = .pause
                            
                            withAnimation{
                                isPaused = true
                            }
                            
                            
                            
                        }, label: {
                            
                            HStack {
                                
                                Text("||")
                                    .font(.custom("Chalkduster", size: 35))
                                    .foregroundColor(Color.white)
                                
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
                                .opacity(playerSettingsUI.haveBombs ? 1.0 : 0.5)
                        })
                            .padding(20)
                            .disabled(!playerSettingsUI.haveBombs)
                        
                    }
                }
            }
            
                
                
            
        }
    }
}

