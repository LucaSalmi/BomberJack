//
//  SwiftUIHostingController.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-02-23.
//

import UIKit
import SwiftUI
import CoreData

struct MyViewSettings {
    
    static let actionNextLevel = 0
    static let actionDefaultBomb = 1
    static let actionTrap = 2
    static let actionShield = 3
    
}

struct ContentView: View {
    
    @State var startGame: Bool = false
    @State var isPaused: Bool = false
    
    
    var body: some View {
        
        if startGame {
            ZStack {
                if isPaused {
                    PauseMenu(startGame: $startGame, isPaused: $isPaused)
                        .zIndex(2)
                    //.transition(.slide)
                    //.animation(.easeInOut)
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
    
    //    func cleanUpDatabase(){
    //
    //        do{
    //            if result.isEmpty{
    //                let statistics = Statistics(context: viewContext)
    //                statistics.killedEnemies = 3
    //            }
    //            else {
    //                for i in 0..<result.count{
    //                    let statisticsData = result[i]
    //                    if i >= 10{
    //                        viewContext.delete(statisticsData)
    //
    //                    }
    //                }
    //            }
    //
    //            try viewContext.save()
    //
    //
    //        }catch{
    //            print("result error")
    //
    //        }
    //
    //    }
    
    
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
                .blur(radius: (self.isPaused == true ? 3 : 0))
        }
    }
    
}

struct MainMenyView: View {
    
    @Binding var startGame: Bool
    
    
    @State var showMapMenu: Bool = false
    @State var index = 1
    @State var offset: CGFloat = 200.0
    
    
    
    var body: some View {
        
        
        ScrollView([.horizontal]){
            
            ZStack{
                
                TabView(selection: $index){
                    OptionsMenu().tag(0)
                        .onAppear {
                            showMapMenu = false
                        }
                    
                    MainView().tag(1)
                        .onAppear {
                            showMapMenu = false
                        }
                    
                    LevelSelectView(showMapMenu: $showMapMenu, startGame: $startGame).tag(2)
                        .onAppear {
                            showMapMenu = true
                        }
                    
                }
                .transition(.slide)
                //Calle was here
                .animation(.easeIn)
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

struct MainView: View{
    
    
    var body: some View{
        
        ZStack{
            
            Image("main_menu_home")
                .resizable()
                .scaledToFill()
            VStack {
                
                HStack{
                    
                    Image("Game_Title")
                        .resizable()
                        .padding(.top, 60)
                        .padding(.leading, 20)
                        .scaledToFit()
                    
                    Spacer(minLength: 400)
                }
                
                HStack {
                    
                    ZStack{
                        
                        Rectangle()
                            .cornerRadius(20)
                            .foregroundColor(.black).opacity(0.5)
                            .frame(width: 200, height: 100)
                        
                        Text("Credits: Luca\nDaniel, Calle & Hampus")
                            .foregroundColor(.white)
                            .frame(width: 180, height: 80)
                        
                    }
                    .padding(.leading, 70)
                    .padding(.top, 30)
                    .padding(.bottom, 40)
                    
                    Spacer()
                    
                    Image("sitting_Dawg")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 200)
                    
                }
                
                Spacer()
                
            }
        }
    }
}

struct LevelSelectView: View{
    
    @Binding var showMapMenu: Bool
    @Binding var startGame: Bool
    
    var body: some View{
        
        
        ZStack{
            
            
            Image("main_menu_play")
                .resizable()
                .scaledToFill()
            
            GeometryReader { _ in
                
                HStack {
                    
                    Spacer()
                    
                    SideViewMapMenu(startBool: $startGame)
                        .offset ( x: showMapMenu ? 0 : UIScreen.main.bounds.width)
                        .animation(.easeInOut(duration: 1), value: showMapMenu)
                    
                }
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

class SwiftUIHostingController: UIHostingController<AttachmentView> {
    
    let persistenceController = PersistenceController.shared
    
    required init?(coder: NSCoder) {
        super.init(coder: coder, rootView: AttachmentView(viewContext: persistenceController.container.viewContext));
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataReaderWriter.loaduserData()
    }
}

struct AttachmentView: View {
    
    let viewContext: NSManagedObjectContext
    
    var body: some View {
        ContentView()
            .environment(\.managedObjectContext, viewContext)
    }
    
}

func checkLevel(result: FetchedResults<Statistics>){
    
    let level = Int(result[0].lastCompletedLevel)
    UserData.currentLevel = level
    
}
