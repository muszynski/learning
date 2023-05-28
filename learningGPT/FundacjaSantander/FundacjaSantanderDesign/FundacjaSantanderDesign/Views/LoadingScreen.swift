//
//  LoadingScreen.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 26/05/2023.
//

import SwiftUI
import CoreData

struct LoadingScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var dataLoaded = false
    @StateObject private var dataManager = DataManager(context: PersistenceController.shared.container.viewContext)
    @State private var loadingStatus: Status = .loading

    var body: some View {
        VStack {
            if loadingStatus == .loading {
                AnimatedLogo()
                    .frame(width: 128, height: 128)
            }
            StatusView(status: loadingStatus)
        }
        .onAppear {
            if dataManager.checkIfDataLoaded() {
                withAnimation(.easeInOut(duration: 0.5)) {
                    loadingStatus = .upToDate
                    dataLoaded = true
                }
            } else {
                loadingStatus = .loading
                dataManager.fetchAndUpdateData(postsPerPage: 50) { error in
                    if let error = error {
                        print("Failed to fetch and update data: \(error.localizedDescription)")
                        loadingStatus = .serverError
                    } else {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            loadingStatus = .upToDate
                            dataLoaded = true
                        }
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $dataLoaded) {
            MainView()
        }
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen()
            .previewLayout(.device)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .onAppear {
                DataManager(context: PersistenceController.preview.container.viewContext)
                    .fetchAndUpdateData(postsPerPage: 50) { _ in }
            }
    }
}

