//  ContentView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 17/05/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(spacing: 0) {
            switch selectedTab {
            case 0:
                StartView()
            case 1:
                AktualnosciView()
            case 2:
                PomagajView()
            case 3:
                ProjektyView()
            default:
                FAQView()
            }
            Spacer()
            Divider()
                .overlay(Color("lightBlue"))
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    TabBarItem(icon: "start", title: "Start", isSelected: selectedTab == 0)
                        .frame(width: geometry.size.width / 5)
                        .onTapGesture { selectedTab = 0 }
                    TabBarItem(icon: "aktualnosci", title: "Aktualności", isSelected: selectedTab == 1)
                        .frame(width: geometry.size.width / 5)
                        .onTapGesture { selectedTab = 1 }
                    TabBarItem(icon: "pomagaj", title: "Pomagaj", isSelected: selectedTab == 2)
                        .frame(width: geometry.size.width / 5)
                        .onTapGesture { selectedTab = 2 }
                    TabBarItem(icon: "projekty", title: "Projekty", isSelected: selectedTab == 3)
                        .frame(width: geometry.size.width / 5)
                        .onTapGesture { selectedTab = 3 }
                    TabBarItem(icon: "faq", title: "FAQ", isSelected: selectedTab == 4)
                        .frame(width: geometry.size.width / 5)
                        .onTapGesture { selectedTab = 4 }
                }
            }.frame(height: 50)
             
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
