//
//  FundacjaSantanderDesignApp.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 17/05/2023.
//

import SwiftUI

@main
struct FundacjaSantanderDesignApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            VStack{
//                PostsView()
//                CategoriesView()
                MainView()
                
            }.environment(\.managedObjectContext, persistenceController.container.viewContext)
                
        }
    }
}
