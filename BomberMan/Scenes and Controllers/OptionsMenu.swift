//
//  OptionsMenu.swift
//  BomberMan
//
//  Created by Luca Salmi on 2022-02-28.
//

import SwiftUI

struct OptionsMenu: View {
    
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
                .scaledToFit()
                
            
            HStack(alignment: .top){
                
                Text("Options")
                    .font(.largeTitle)
                    .padding()
                //First Column
                VStack{
                    
                    
                    List(){
                        
                        ForEach(myStats.sorted(by: >), id: \.key) { key, value in
                            
                            
                            Text(key + ": " + String(value)).listRowBackground(Color.clear)
                                
                        }
                    }
                    .background(.black.opacity(0.4))
                    .onAppear(perform: {
                        UITableView.appearance().backgroundColor = .clear
                    })
                    
                    
                    
                    
                    
                    //Second Column
                    VStack{
                        
                    }
                }
            }
        }
        .ignoresSafeArea()
        
    }
    
    
    struct OptionsMenu_Previews: PreviewProvider {
        static var previews: some View {
            OptionsMenu()
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
