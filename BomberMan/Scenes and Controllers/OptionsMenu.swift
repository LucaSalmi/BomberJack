//
//  OptionsMenu.swift
//  BomberMan
//
//  Created by Luca Salmi on 2022-02-28.
//

import SwiftUI

struct OptionsMenu: View {
    
    @ObservedObject var options = Options.options
    
    var body: some View {
        
        let myStats: [String: Int] = [
            "Killed Enemies": UserData.enemiesKilled,
            "Bombs Dropped": UserData.bombsDropped,
            "Hidden in Barrel": UserData.barrelUsed,
            "Number of Deaths": UserData.numberOfDeaths,
        ]
        
        ZStack{
            
            Image("page_view_one")
                .resizable()
                .scaledToFill()
            
            VStack{
                
                Spacer(minLength: 50)
                                
                HStack{
                    
                    Spacer()
                    
                    Text("Options")
                        .font(.largeTitle)
                    
                    Spacer()
                                    
                    Text("Statistics")
                        .font(.largeTitle)
                    
                    Spacer()
                }
                .scaledToFit()
                .padding()
                
                HStack{
                    
                    //First Column
                    VStack(){
                        
  
                        Toggle("Music", isOn: self.$options.isMusicOn)
                            .padding()
                            .onReceive([self.$options.isMusicOn].publisher.first(), perform: { (value) in
                                if options.isMusicOn{
                                    SoundManager.playBGM(bgmString: SoundManager.mainMenuBGM)
                                }else{
                                    SoundManager.playBGM(bgmString: SoundManager.mainMenuBGM)
                                }
                            })
                        Toggle("Sound Effects", isOn: self.$options.areSFXOn)
                            .padding()
                        Toggle("Camera Shake", isOn: self.$options.isScreenShakeOn)
                            .padding()
                        
                        Spacer()
                        
                    }
                    .padding()
                    
                    //Second Column
                    VStack(){
                                            
                        List(){
                                       
                            ForEach(myStats.sorted(by: >), id: \.key) { key, value in
                                
                                HStack{
                                    Spacer()
                                    Text(key + ": " + String(value)).listRowBackground(Color.clear)
                                    Spacer()
                                }
                            }
                        }
                        .onAppear(perform: {
                            UITableView.appearance().backgroundColor = .clear
                        })
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 50))
                    }
                    Spacer()
                }
            }
        }
        .ignoresSafeArea()
        
    }
    
    
    struct OptionsMenu_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                OptionsMenu()
                    .previewInterfaceOrientation(.landscapeLeft)
                
            }
        }
    }
}
