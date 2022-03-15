//
//  PauseMenu.swift
//  BomberMan
//
//  Created by Calle Höglund on 2022-03-14.
//
import UIKit
import SwiftUI
import SpriteKit
import GameplayKit

struct PauseMenu: View {
    
    @Binding var startGame: Bool
    @Binding var isPaused: Bool
    
    @ObservedObject var swiftUICommunicator = SwiftUICommunicator.instance
    @ObservedObject var options = Options.options
    
    
    
    var body: some View {
        
        
        
        ZStack {
            
            Image("pausebackground")
                .resizable()
                .frame(width: 470, height: 360)
                .shadow(color: Color.black, radius: 100, x: 0, y: 0)
            
            
            
            
            VStack{
                
                
                Text(swiftUICommunicator.isGameOver ? "Game Over" : "Paused")
                
                
                HStack{
                    
                    
                    VStack(alignment: .leading){
                        
                        
                        
                        if swiftUICommunicator.isGameOver{
                            
                            //Text("GAME OVER")
                            
                            Button(action: {
                                let levelNumber = UserData.currentLevel
                                GameScene.viewController!.presentScene("GameScene\(levelNumber)")
                                
                                isPaused = false
                                swiftUICommunicator.isGameOver = false
                                
                                
                            }, label: {
                                
                                Label("Restart", systemImage: "arrowtriangle.right.circle")
                                
                                
                            }).padding(.vertical, 10)
                            
                        }
                        
                        else{
                            
                            //Text("PAUSED")
                            
                            Button(action: {
                                if GameViewController.currentGameScene?.actionManager != nil {
                                    withAnimation(.easeOut(duration: 0.3)){
                                        isPaused = false
                                    }
                                    
                                    GameScene.gameState = .play
                                }
                            }, label: {
                                
                                Label("Continue", systemImage: "arrowtriangle.right.circle")
                                
                                
                                
                                
                            }).padding(.vertical, 10)
                            
                            
                        }
                        
                        Button(action: {
                            if GameViewController.currentGameScene?.actionManager != nil {
                                isPaused = false
                                GameScene.gameState = .play
                                GameViewController.currentGameScene?.actionManager.handleInput(id: MyViewSettings.actionNextLevel, isPaused: isPaused)
                            }
                        }, label: {
                            
                            
                            Label("Next Level", systemImage: "arrowshape.turn.up.right")
                            
                            
                        }).padding(.vertical, 10)
                        
                        
                        Button(action: {
                            startGame = false
                            isPaused = false
                            swiftUICommunicator.isGameOver = false
                            GameScene.gameState = .play
                            GameViewController.currentGameScene?.player?.resetInventory()
                            GameViewController.currentGameScene?.isGameOver = false
                            dataReaderWriter.updateDatabase()
                        }, label: {
                            
                            Label("Main Menu", systemImage: "house")
                            
                            
                            
                        }).padding(.vertical, 10)
                        
                        
                        
                        
                    }
                    .frame(width: 200, height: 200, alignment: .center)
                    
                    if !swiftUICommunicator.isGameOver{
                        
                        VStack(alignment: .trailing){
                            
                            
                            Toggle("Music", isOn: self.$options.isMusicOn)
                                .onReceive([self.$options.isMusicOn].publisher.first(), perform: { (value) in
                                    if options.isMusicOn{
                                        SoundManager.playBGM(bgmString: SoundManager.mainMenuBGM)
                                    }else{
                                        SoundManager.playBGM(bgmString: SoundManager.mainMenuBGM)
                                    }
                                }).toggleStyle(myCheckbox())
                                
                            
                            Toggle("Sound Effects", isOn: self.$options.areSFXOn).toggleStyle(myCheckbox())
                            Toggle("Camera Shake", isOn: self.$options.isScreenShakeOn).toggleStyle(myCheckbox())
                            
                        }
                        .padding(.leading, 20)
                        .frame(width: 200, height: 200, alignment: .center)
                        
                    }
                }
                
                
            }
            .font(.custom("Chalkduster", size: 18))
            .foregroundColor(Color.black)
            .shadow(color: Color.red, radius: 0, x: 0, y: 0)
            .opacity(1)
            
            
        }.transition(.scale)
        
        
        
    }
    
}

struct myCheckbox: ToggleStyle{
    var text: String = ""
    
    func makeBody(configuration: Configuration) -> some View {
        HStack{
            configuration.label
            Button{
                configuration.isOn.toggle()
            } label: {
                HStack{
                    
                Spacer()
                Image(configuration.isOn ? "button_on" : "button_off")
                    .resizable()
                    .frame(width: 65, height: 40, alignment: .trailing)
                }
            }
            
        }
    }
    
}



