//
//  TabMenu.swift
//  BomberMan
//
//  Created by Luca Salmi on 2022-03-02.
//

import SwiftUI

struct Tab {
    var icon: Image?
    var title: String
}

struct TabMenu: View {
    var fixed = false
    var tabs: [Tab]
    var geoWidth: CGFloat
    @Binding var selectedTab: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        ForEach(0 ..< tabs.count, id: \.self) { row in
                            Button(action: {
                                withAnimation {
                                    selectedTab = row
                                }
                            }, label: {
                                VStack(spacing: 0) {
                                    HStack {
                                        // Image
                                        AnyView(tabs[row].icon)
                                            .foregroundColor(.white)
                                            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                                        
                                        // Text
                                        Text(tabs[row].title)
                                            .font(Font.system(size: 18, weight: .semibold))
                                            .foregroundColor(Color.white)
                                            .padding(EdgeInsets(top: 10, leading: 3, bottom: 10, trailing: 15))
                                    }
                                    .frame(width: fixed ? (geoWidth / CGFloat(tabs.count)) : .none, height: 52)
                                    // Bar Indicator
                                    Rectangle().fill(selectedTab == row ? Color.white : Color.clear)
                                        .frame(height: 3)
                                }.fixedSize()
                            })
                                .accentColor(Color.white)
                                .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .onChange(of: selectedTab) { target in
                        withAnimation {
                            proxy.scrollTo(target)
                        }
                    }
                }
            }
        }
        .frame(height: 45)
        .onAppear(perform: {
            UIScrollView.appearance().backgroundColor = UIColor(#colorLiteral(red: 0, green: 0.1098039216, blue: 0.2509803922, alpha: 0.8))
            UIScrollView.appearance().bounces = fixed ? false : true
        })
        .onDisappear(perform: {
            UIScrollView.appearance().bounces = true
        })
    }
}

struct TabMenu_Previews: PreviewProvider {
    static var previews: some View {
           TabMenu(fixed: true,
                tabs: [.init(icon: Image(systemName: "star.fill"), title: "Tab 1"),
                       .init(icon: Image(systemName: "star.fill"), title: "Tab 2"),
                       .init(icon: Image(systemName: "star.fill"), title: "Tab 3")],
                geoWidth: 375,
                selectedTab: .constant(0))
            .previewInterfaceOrientation(.landscapeLeft)
       }
}
