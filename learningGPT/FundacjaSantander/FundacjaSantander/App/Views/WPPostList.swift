//
//  List.swift
//  FundacjaSantander
//
//  Created by Łukasz Muszyński on 24/04/2023.
//
import SwiftUI
import Foundation

struct WPPostList: View {
    @State private var posts: [WPPost] = []
    @State private var currentPage: Int = 1
    @State private var isLoading: Bool = false

    private func loadMorePosts() {
        if isLoading {
            return
        }
        isLoading = true

        let username = "api_read_swift"
        let appPassword = "t52f B3Wz UHs5 M3tM e77W DPmL"
        
        getAuthToken { authToken in
            getWPPosts(username: username, appPassword: appPassword, page: currentPage) { fetchedPosts in
                isLoading = false
                posts += fetchedPosts
                currentPage += 1
            }
        }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(posts) { post in
                        VStack(alignment: .leading) {
                            Text(post.title.rendered)
                                .font(.headline)
                            Text(post.link)
                                .font(.subheadline)
                        }
                        .padding()
                    }
                    if isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    }
                }
                .onAppear {
                    loadMorePosts()
                }
                Button("Load more") {
                    loadMorePosts()
                }
                .padding()
            }
            .navigationBarTitle("WordPress Posts")
        }
    }
}

struct WPPostList_Previews: PreviewProvider {
    static var previews: some View {
        WPPostList()
    }
}

