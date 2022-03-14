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
                            
                            
                            
                            withAnimation(.easeIn(duration: 1)) {
                                isPaused = true
                            }
                            
                            
                            
                            
                        }, label: {
                            
                            HStack {
                                
                                Text("||")
                                    .font(.custom("Chalkduster", size: 35))
                                    .foregroundColor(Color.white)
                                
                                
                                //                                Rectangle()
                                //                                    .fill(Color.white)
                                //                                    .frame(width: 10, height: 40)
                                //                                    .border(Color.black, width: 1)
                                //
                                //                                Rectangle()
                                //                                    .fill(Color.white)
                                //                                    .frame(width: 10, height: 40)
                                //                                    .border(Color.black, width: 1)
                                
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

struct PauseMenu: View {
    
    @Binding var startGame: Bool
    @Binding var isPaused: Bool
    
    @ObservedObject var swiftUICommunicator = SwiftUICommunicator.instance
    
    var body: some View {
        
        ZStack {
            
            //            let cornerRadius = CGFloat(10)
            //            let borderWidth = CGFloat(2)
            
            
            //            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            //
            //
            //
            //                .background(Image("pausebackground"))
            ////                .overlay(
            ////                    RoundedRectangle(cornerRadius: cornerRadius)
            ////                        .stroke(Color.white, lineWidth: borderWidth)
            ////                )
            
            Image("pausebackground")
                .resizable()
                .frame(width: 400, height: 300)
                .shadow(color: Color.black, radius: 100, x: 0, y: 0)
            
            
            VStack {
                
                if swiftUICommunicator.isGameOver{
                    
                    Text("GAME OVER")
                    
                    Button(action: {
                        let levelNumber = UserData.currentLevel
                        GameScene.viewController!.presentScene("GameScene\(levelNumber)")
                        
                        isPaused = false
                        swiftUICommunicator.isGameOver = false
                        
                        ExplosionSettings.explosionsArray.removeAll()
                        Bomb.bombs.removeAll()
                    }, label: {
                        
                        Label("Restart", systemImage: "arrowtriangle.right.circle")
                            .padding(10)
                    })
                    
                }
                
                else{
                    
                    Text("PAUSED")
                    
                    Button(action: {
                        if GameViewController.currentGameScene?.actionManager != nil {
                            withAnimation(.easeOut(duration: 0.3)){
                                isPaused = false
                            }
                            
                            
                            GameScene.gameState = .play
                        }
                    }, label: {
                        
                        Label("Continue", systemImage: "arrowtriangle.right.circle")
                            .padding(10)
                    })
                    
                }
                
                Button(action: {
                    if GameViewController.currentGameScene?.actionManager != nil {
                        isPaused = false
                        GameScene.gameState = .play
                        GameViewController.currentGameScene?.actionManager.handleInput(id: MyViewSettings.actionNextLevel, isPaused: isPaused)
                    }
                }, label: {
                    
                    Label("Next Level", systemImage: "arrowshape.turn.up.right")
                        .padding(10)
                    
                })
                    .padding([.top, .bottom], 20)
                
                Button(action: {
                    startGame = false
                    isPaused = false
                    swiftUICommunicator.isGameOver = false
                    GameScene.gameState = .play
                    GameViewController.currentGameScene?.player?.resetInventory()
                    dataReaderWriter.updateDatabase()
                }, label: {
                    
                    Label("Main Menu", systemImage: "house")
                        .padding(10)
                })
                
                
            }
            .font(.custom("Chalkduster", size: 18))
            .foregroundColor(Color.black)
            .shadow(color: Color.red, radius: 0, x: 0, y: 0)
        }
    }
    
}



