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
    @StateObject var postQuery = PostQuery()
    @StateObject private var dataManager: DataManager
    @State private var loadingStatus: Status = .loading

    init() {
        let postQuery = PostQuery()
        _postQuery = StateObject(wrappedValue: postQuery)
        _dataManager = StateObject(wrappedValue: DataManager(context: PersistenceController.shared.container.viewContext, postQuery: postQuery))
    }

    var body: some View {
        VStack {
            Text("\(postQuery.fetchedPostsCount) / \(postQuery.totalPosts) posts fetched")
                .font(.custom("SantanderText-Regular", size: 13))
                .foregroundColor(Color("fontGray"))
            
            if loadingStatus == .loading {
                AnimatedLogo()
                    .frame(width: 128, height: 128)
            }
            StatusView(status: loadingStatus)
        }
        .onAppear {
            loadingStatus = .loading
            dataManager.fetchAndUpdateData(postsPerPage: postPerPage) { error in
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


        .fullScreenCover(isPresented: $dataLoaded) {
            MainView()
        }
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        let postQuery = PostQuery()
        LoadingScreen()
            .previewLayout(.device)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .onAppear {
                DataManager(context: PersistenceController.preview.container.viewContext, postQuery: postQuery)
                    .fetchAndUpdateData(postsPerPage: 50) { _ in }
            }
    }
}

