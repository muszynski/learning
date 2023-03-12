//
//  bottomMenu.swift
//  rebe2CoreData
//
//  Created by Łukasz Muszyński on 12/03/2023.
//

import SwiftUI

struct BottomMenu: View {
    
    @State private var selection = 0
    var body: some View {

        ZStack {
            TabView(selection: $selection) {
                    ListView()
                        .tabItem {
                            Label("List View", systemImage: "list.bullet")
                        }
                        .tag(0)
                    AddItem()
                        .tabItem {
                            Label("Add Item", systemImage: "plus.circle.fill")
                        }
                        .tag(1)
                        .toolbarBackground(
                                Color.yellow,
                                for: .tabBar)
                }
            .accentColor(.red)
            .toolbarBackground(Color.red ,for: .tabBar)
        }
    }
}

struct bottomMenu_Previews: PreviewProvider {
    static var previews: some View {
        BottomMenu()
    }
}
