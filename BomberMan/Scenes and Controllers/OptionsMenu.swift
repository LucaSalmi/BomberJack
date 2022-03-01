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
                                
                HStack{
                    
                    Spacer()
                    
                    Text("Options")
                        .font(.largeTitle)
                        .padding()
                    
                    Spacer()
                                    
                    Text("Stats")
                        .font(.largeTitle)
                        .padding()
                    
                    Spacer()
                }
                .padding()
                
                HStack{
                    
                    //First Column
                    VStack(alignment: .center){
  
                        Toggle("Music", isOn: $music)
                        Toggle("Sound Effects", isOn: $sfx)
                        Toggle("Camera Shake", isOn: $cameraShake)
                        
                    }
                    .padding()
                    
                    //Second Column
                    VStack(alignment: .center){
                                            
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
                    }
                    .padding()
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
