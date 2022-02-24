//
//  SwiftUIHostingController.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-02-23.
//

import UIKit
import SwiftUI

struct MyView: View {
    
    @State public var startGame: Bool = false
    
    var body: some View {
        
        if startGame {
            GameView(startGame: $startGame)
        }
        else {
            MainMenyView(startGame: $startGame)
        }
        
    }
    
}

struct GameView: View {
    
    @Binding var startGame: Bool
    
    var body: some View {
        
        ZStack {
            
            //Game UI layer
            GameUIView(startGame: $startGame)
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
    
    var body: some View {
        
        VStack {
            HStack {
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
                        GameViewController.currentGameScene?.actionManager.activateShield()
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
                Spacer()
            }
            Spacer()
        }
        
    }
    
}

struct MainMenyView: View {
    
    @Binding var startGame: Bool
    
    var body: some View {
        
        ZStack {
            Image("mainmenu_no_props")
                .resizable()
                .scaledToFill()
            Button(action: {
                startGame = true
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
        
    }
    
}

struct ViewController: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
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
