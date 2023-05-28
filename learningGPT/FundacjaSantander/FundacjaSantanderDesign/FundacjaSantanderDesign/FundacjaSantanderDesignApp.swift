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
//    let dataManager = DataManager(context: PersistenceController.shared.container.viewContext)
//
//    init() {
//        dataManager.fetchAndUpdateData(postsPerPage: 50) { error in
//            if let error = error {
//                print("Failed to fetch and update data: \(error)")
//            }
//        }
//    }

    var body: some Scene {
        WindowGroup {
            VStack{
                LoadingScreen()
            }.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

