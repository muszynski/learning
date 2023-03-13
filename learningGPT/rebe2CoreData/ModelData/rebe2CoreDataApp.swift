//
//  rebe2CoreDataApp.swift
//  rebe2CoreData
//
//  Created by Łukasz Muszyński on 08/03/2023.
//

import SwiftUI

@main

struct rebe2CoreDataApp: App {
    let persistenceController = PersistenceController.shared
    
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            BottomMenu()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { (newScenePhase) in
            switch scenePhase {
            case .background:
                print("in background")
                persistenceController.save()
            case .inactive:
                print("in inactive")
            case .active:
                print("active")
            @unknown default:
                print("default")
            }
        }
    }
}
