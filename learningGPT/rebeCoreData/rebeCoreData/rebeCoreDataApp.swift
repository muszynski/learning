//
//  rebeCoreDataApp.swift
//  rebeCoreData
//
//  Created by Łukasz Muszyński on 08/03/2023.
//

import SwiftUI

@main
struct rebeCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
