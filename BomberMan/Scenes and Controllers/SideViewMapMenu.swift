//
//  SideViewMapMenu.swift
//  BomberMan
//
//  Created by Hampus Brandtman on 2022-03-01.
//

import SwiftUI

struct SideViewMapMenu: View {
    var body: some View {
        VStack{
            Text("MAP")
                .padding(.horizontal, 100)
                .padding(.top, 50)
            VStack{
                
                HStack{
                    
                    Button
                    
                }
            }
            Spacer()
            
        }
        .scaledToFill()
        .foregroundColor(.white)
        .background(.black).opacity(0.5)
        .edgesIgnoringSafeArea(.trailing)
    }
}

struct SideViewMapMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideViewMapMenu()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
