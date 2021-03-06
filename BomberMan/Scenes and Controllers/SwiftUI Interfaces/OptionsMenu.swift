//
//  OptionsMenu.swift
//  BomberMan
//
//  Created by Luca Salmi on 2022-02-28.
//

import SwiftUI
import SceneKit
import CoreData

struct OptionsMenu: View {
    
    var result: FetchedResults<Statistics>
    @State var tabIndex = 0
    
    var body: some View {
        
        ZStack{
            
            Image("main_menu_options")
                .resizable()
                .scaledToFill()
            
            VStack{
                
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 40)
                        .padding(.top, 25)
                        .padding(.bottom, 110)
                        .padding(.leading, 25)
                        .padding(.trailing, 25)
                        .opacity(0.2)
                        
                        
                    
                    VStack{
                        CustomTopTabBar(tabIndex: $tabIndex)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 25)
                        if tabIndex == 0 {
                            OptionsTab()
                        }
                        else {
                            StatisticsTab(result: result)
                        }
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width - 30, alignment: .top)
                    .foregroundColor(.white).opacity(1.0)
                }
            }
            .padding(.top, 50)
            
        }
    }
}


struct CustomTopTabBar: View {
    @Binding var tabIndex: Int
    
    
    var body: some View {
        
        HStack(spacing: 20) {
            TabBarButton(text: "Options", isSelected: .constant(tabIndex == 0))
                .onTapGesture { onButtonTapped(index: 0) }
            TabBarButton(text: "Statistics", isSelected: .constant(tabIndex == 1))
                .onTapGesture { onButtonTapped(index: 1) }
            Spacer()
        }
        .border(width: 1, edges: [.bottom], color: .black)
        
        .padding()
    }
    
    private func onButtonTapped(index: Int) {
        withAnimation { tabIndex = index }
    }
}

struct TabBarButton: View {
    let text: String
    @Binding var isSelected: Bool
    var body: some View {
        Text(text)
            .fontWeight(isSelected ? .heavy : .regular)
            .font(.custom("Chalkduster", size: 16))
            .foregroundColor(Color.white)
            .padding(.bottom,10)
            .border(width: isSelected ? 2 : 1, edges: [.bottom], color: .black)
    }
}

struct EdgeBorder: Shape {
    
    var width: CGFloat
    var edges: [Edge]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading: return rect.minX
                case .trailing: return rect.maxX - width
                }
            }
            
            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width
                }
            }
            
            var w: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return self.width
                }
            }
            
            var h: CGFloat {
                switch edge {
                case .top, .bottom: return self.width
                case .leading, .trailing: return rect.height
                }
            }
            path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
        }
        return path
    }
}

extension View {
    func border(width: CGFloat, edges: [Edge], color: SwiftUI.Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}


struct OptionsTab: View{
    
    @ObservedObject var options = Options.options
    
    var body: some View{
        
        VStack(){
            
            Toggle("Music", isOn: self.$options.isMusicOn)
                .onReceive([self.$options.isMusicOn].publisher.first(), perform: { (value) in
                    if options.isMusicOn{
                        SoundManager.playBGM(bgmString: SoundManager.mainMenuBGM)
                    }else{
                        SoundManager.playBGM(bgmString: SoundManager.mainMenuBGM)
                    }
                })
                
            Toggle("Sound Effects", isOn: self.$options.areSFXOn)
                
            Toggle("Camera Shake", isOn: self.$options.isScreenShakeOn)
                
            
        }
        .toggleStyle(myCheckbox(width: 100, height: 50))
        .padding()
        .scaledToFit()
        .font(.custom("Chalkduster", size: 20))
        .foregroundColor(Color.white)
        .onDisappear(perform: {
            dataReaderWriter.saveUserData()
        })
    }
}

struct StatisticsTab: View{
    
    var result: FetchedResults<Statistics>
    
    var body: some View{
        
        let statsArray: [String : Int64] = checkStat()
        
        
        HStack(){
            
            let columns: [GridItem] =
            Array(repeating: .init(.flexible()), count: 2)
            
            
            LazyVGrid(columns: columns){
                
                ForEach(statsArray.sorted(by: >), id: \.key) { key, value in
                    
                    HStack{
                        
                        Text("\(key) \(value)").listRowBackground(Color.clear)
                            .font(.custom("Chalkduster", size: 25))
                            .foregroundColor(Color.white)
                        
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 70, trailing: 30))
            .onAppear(perform: {
                if result.isEmpty{
                    print("empty DataBase")
                }
            })
        }
    }
    
    func checkStat() -> [String : Int64]{
        
        if result.isEmpty{
            
            return [
                
                "Enemies Killed:" : 0,
                "Bombs Dropped:" : 0,
                "Barrel Used:" : 0,
                "Number of Deaths:" : 0
            ]
            
        }else{
            
            return [
                
                "Enemies Killed:" : result[0].killedEnemies,
                "Bombs Dropped:" : result[0].bombsDropped,
                "Barrel Used:" : result[0].usedBarrel,
                "Number of Deaths:" : result[0].numberOfDeaths
            ]
        }
        
    }
    
}
