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
                    startGame = false
                }, label: {
                    Text("Main Menu")
                        .foregroundColor(.black)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                                
                                
                        )
                })
                    .padding([.top], 20)
                    
                Button(action: {
                    if GameViewController.currentGameScene?.actionManager != nil {
                        GameViewController.currentGameScene?.actionManager.handleInput(id: MyViewSettings.actionNextLevel, isPaused: isPaused)
                    }
                }, label: {
                    Text("Next Level")
                        .foregroundColor(.black)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )
                })
                    .padding([.top], 20)
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
                Button(action: {
                    isPaused.toggle()
                    if isPaused {
                        GameScene.gameState = .pause
                    }
                    else {
                        GameScene.gameState = .play
                    }
                }, label: {
                    Text("Pause")
                        .foregroundColor(.black)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )
                       
                })
                    .padding([.top], 20)
                    
            }
        }
        
    }
    
}
