//
//  OptionsMenu.swift
//  BomberMan
//
//  Created by Luca Salmi on 2022-02-28.
//

import SwiftUI

struct OptionsMenu: View {
    
    @State var music = true
    @State var sfx = true
    @State var cameraShake = true
    
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
                        
  
                        Toggle("Music", isOn: $music)
                            .padding()
                        Toggle("Sound Effects", isOn: $sfx)
                            .padding()
                        Toggle("Camera Shake", isOn: $cameraShake)
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
