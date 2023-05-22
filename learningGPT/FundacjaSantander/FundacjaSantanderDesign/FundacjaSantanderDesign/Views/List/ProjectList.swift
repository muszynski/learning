//
//  ProjektyView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 17/05/2023.
//

import SwiftUI
import CoreData

struct ProjectList: View {
    @FetchRequest(
        entity: Post.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Post.date, ascending: false)]
    ) var posts: FetchedResults<Post>
    
    @ObservedObject var postService = PostService()
    @State private var showingSafariView = false
    @State private var currentURL: URL?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                LazyVStack {
                    ForEach(Array(posts.enumerated()), id: \.1.self) { index, post in
                        Button(action: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                if let url = URL(string: post.link ?? defaultLink) {
                                    currentURL = url
                                    showingSafariView = true
                                }
                            }
                        }) {
                            ProjectItem(
                                imageData: post.thumbnailsImage,
                                title: "\(index + 1). \(post.title ?? "Title")",
                                content: post.content ?? "Content",
                                categoryName: getCategoryNames(from: post.categories).joined(separator: ", "),
                                link: post.link ?? defaultLink,
                                datePublication: post.date.map(formattedDateDayMontYear(from:)) ?? "Data Publikacji"
                            )
                        }
                        .onAppear {
                            if index == posts.count - 1 && postService.hasMorePages {
                                postService.fetchPosts()
                                    .sink(receiveCompletion: { completion in
                                        switch completion {
                                        case .failure(let error):
                                            print("Error: \(error.localizedDescription)")
                                        case .finished:
                                            break
                                        }
                                    }, receiveValue: { fetchedPosts in
                                        savePostsToCoreData(posts: fetchedPosts) { error in // add error here
                                            if let error = error {
                                                // handle error
                                                print("Error saving posts: \(error)")
                                                return
                                            }
                                            print("Próbuję pobrać nowe dane")
                                            DispatchQueue.main.async {
                                                postService.hasMorePages = !fetchedPosts.isEmpty
                                            }
                                        }
                                    })
                                    .store(in: &postService.cancellables)
                            }
                        }


                    }
                }
                .sheet(isPresented: $showingSafariView) {
                    if let url = currentURL {
                        SafariView(url: url)
                    }
                }

                // Dodanie StatusView pod listą
                if postService.currentStatus != .idle {
                    StatusView(status: postService.currentStatus)
                        .transition(.move(edge: .top))
                }
            }
            .padding()
            .animation(.default, value: postService.currentStatus)
        }
    }
}

struct ProjectList_Previews: PreviewProvider {
    static var previews: some View {
        ProjectList()
    }
}

