//
//  SwiftUIHostingController.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-02-23.
//

import UIKit
import SwiftUI

struct MyViewSettings {
    
    static let actionNextLevel = 0
    static let actionDefaultBomb = 1
    static let actionTrap = 2
    static let actionShield = 3
    
}

struct MyView: View {
    
    @State var startGame: Bool = false
    @State var isPaused: Bool = false
    
    var body: some View {
        
        if startGame {
            ZStack {
                if isPaused {
                    PauseMenu()
                        .zIndex(2)
                }
                GameView(startGame: $startGame, isPaused: $isPaused)
                    .zIndex(1)
            }
            
        }
        else {
            MusicView(bgmString: SoundManager.mainMenuBGM)
            MainMenyView(startGame: $startGame)
        }
        
    }
    
}

struct MusicView: View {
    
    init(bgmString: String) {
        SoundManager.playBGM(bgmString: bgmString)
    }
    
    var body: some View {
        Text("")
    }
    
}

struct PauseMenu: View {
    var body: some View {
        Rectangle()
            .frame(width: 300, height: 200)
    }
}

struct GameView: View {
    
    @Binding var startGame: Bool
    @Binding var isPaused: Bool
    
    var body: some View {
        
        ZStack {
            
            //Game UI layer
            GameUIView(startGame: $startGame, isPaused: $isPaused)
                .zIndex(2)
            
            //Game Scene Layer (ViewController)
            ViewController()
                .ignoresSafeArea()
                .zIndex(1)
        }
        
    }
}

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
                    Text("Default Bomb")
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
                        GameViewController.currentGameScene?.actionManager.handleInput(id: MyViewSettings.actionTrap, isPaused: isPaused)
                    }
                }, label: {
                    Text("Trap")
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
                        GameViewController.currentGameScene?.actionManager.handleInput(id: MyViewSettings.actionShield, isPaused: isPaused)
                    }
                }, label: {
                    Text("Shield Barrel")
                        .foregroundColor(.black)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )
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

struct MainMenyView: View {
    
    @Binding var startGame: Bool
    @State var button: Bool = false
    
    var body: some View {
        
        ZStack {
            Image("mainmenu_no_props")
                .resizable()
                .scaledToFill()
            Button(action: {
                //startGame = true
                button = true
            }, label: {
                Text("Start Game")
                    .foregroundColor(.black)
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 1)
                    )
            })
        }
        .ignoresSafeArea()
        .sheet(isPresented: $button, onDismiss: {button = false}, content: {menu()})
    }
    
}

struct menu: View{
    
    @State private var isShown = false
    
    var body: some View{
        
        VStack {            // container to animate transition !!
            if isShown {
                VStack(spacing: 8) {
                    Text("A great content of my new sheet")
                    Label("still not done", systemImage: "guitars")
                    Text("I'm done now")
                }
                .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut(duration: 2.0), value: isShown)
        .onAppear {
            isShown = true       // << activate !!
        }
    }
    
    
}


struct ViewController: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        SoundManager.playBGM(bgmString: SoundManager.inGameBGM)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "gameViewController")
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
       
    }
}

class SwiftUIHostingController: UIHostingController<MyView> {

    required init?(coder: NSCoder) {
        super.init(coder: coder, rootView: MyView());
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
