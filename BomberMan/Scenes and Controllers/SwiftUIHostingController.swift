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
                    PauseMenu(startGame: $startGame, isPaused: $isPaused)
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

struct MainMenyView: View {
    
    @Binding var startGame: Bool
    @State var index = 1
    @State var offset: CGFloat = 200.0
    
    var body: some View {
        
        
        ScrollView([.horizontal]){
            
            ZStack{
                
                TabView(selection: $index){
                    OptionsMenu().tag(0)
                    TabTwo().tag(1)
                    TabThree(startGame: $startGame).tag(2)
                }
                .transition(.slide)
                //Calle was here
                .animation(.easeInOut)
                .tabViewStyle(.page(indexDisplayMode: .never))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 50)
                
                
                VStack{
                    Spacer()
                    
                    HStack(spacing: 0){
                        
                        Text("Options")
                            .foregroundColor(self.index == 0 ? .white : .white.opacity(0.7))
                            .fontWeight(.bold)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(.black.opacity(self.index == 0 ? 1 : 0))
                            .clipShape(Capsule())
                            .onTapGesture {
                                self.index = 0
                            }
                        
                        Text("Home")
                            .foregroundColor(self.index == 1 ? .white : .white.opacity(0.7))
                            .fontWeight(.bold)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(.black.opacity(self.index == 1 ? 1 : 0))
                            .clipShape(Capsule())
                            .onTapGesture {
                                self.index = 1
                            }
                        
                        Text("Play")
                            .foregroundColor(self.index == 2 ? .white : .white.opacity(0.7))
                            .fontWeight(.bold)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(.black.opacity(self.index == 2 ? 1 : 0))
                            .clipShape(Capsule())
                            .onTapGesture {
                                self.index = 2
                            }
                    }
                    .background(Color.black.opacity(0.1))
                    .clipShape(Capsule())
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                    
                }
            }
            
            
            
        }.edgesIgnoringSafeArea(.all)
            .scaledToFill()
        
    }
}

struct TabTwo: View{
    
    
    var body: some View{
        
        ZStack{
            HStack{
                Button {
                    
                } label: {
                    Text("Options")
                    
                }
            }
            
            Image("page_view_two")
                .resizable()
                .scaledToFill()
            
            Text("Second Tab")
            
        }
    }
}

struct TabThree: View{
    
    @State private var showMapMenu: Bool = false
    
    @Binding var startGame: Bool
    
    
    var body: some View{
        
        ZStack{
            
            Image("page_view_three")
                .resizable()
                .scaledToFill()
            
            Text("Third Tab")
            
            GeometryReader { _ in
                
                HStack {
                    
                    Spacer()
                    
                    SideViewMapMenu(startGame: $startGame)
                        .offset ( x: showMapMenu ? 0 : UIScreen.main.bounds.width)
                }
                
            }
            
            HStack {
                Button {
                    self.showMapMenu.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding(30)
                    
                }
                
                Spacer()
            }
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
        dataReaderWriter.loaduserData()
    }
}
