//
//  simplCDApp.swift
//  simplCD
//
//  Created by Łukasz Muszyński on 07/03/2023.
//

import SwiftUI

@main
struct simplCDApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
