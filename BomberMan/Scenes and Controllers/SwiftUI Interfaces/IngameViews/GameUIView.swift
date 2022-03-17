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
                    
                    ZStack{
                        
                        VStack{
                            
                            Spacer()
                            
                            HStack{
                                
                                Spacer()
                                
                                Image("gui_ability_palceholder")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height*0.65 , alignment: .trailing)
                                    .opacity(0.8)
                                
                                
                            }
                        }
                        
                        
                        VStack{
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
                                        .scaledToFit()
                                        .frame(width: 60, height: 60, alignment: .center)
                                        .padding(.bottom, 30)
                                    
                                })
                                
                                
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
                                        .scaledToFit()
                                        .frame(width: 60, height: 60, alignment: .center)
                                })
                                    .padding(.trailing, 20)
                                
                                Button(action: {
                                    if GameViewController.currentGameScene?.actionManager != nil {
                                        GameViewController.currentGameScene?.actionManager.handleInput(id: MyViewSettings.actionDefaultBomb, isPaused: isPaused)
                                    }
                                }, label: {
                                    Image("bomb")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60, alignment: .center)
                                        .opacity(playerSettingsUI.haveBombs ? 1.0 : 0.5)
                                })
                                    .disabled(!playerSettingsUI.haveBombs)
                                
                            }
                        }
                        .padding(.trailing, 50)
                        .padding(.bottom, 50)
                        .shadow(color: .white, radius: 10, x: 0, y: 0)
                        
                    }.ignoresSafeArea()
                }
            }
            
            
            
            
        }
    }
}

