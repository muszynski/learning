//
//  ContentView.swift
//  LearningPath
//
//  Created by Łukasz Muszyński on 23/02/2023.
//

import SwiftUI

struct NavigationTabs: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            ListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("List")
                }
            
            RemindersView()
                .tabItem {
                    Image(systemName: "bell.fill")
                    Text("Reminders")
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTabs()
    }
}
