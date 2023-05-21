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
    
    @ObservedObject var dataService = DataService()
    @State private var showingSafariView = false
    @State private var currentURL: URL?
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
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
                }
                .sheet(isPresented: $showingSafariView) {
                    if let url = currentURL {
                        SafariView(url: url)
                    }
                }
                if dataService.hasMorePages {
                    Button(action: {
                        dataService.fetchMorePosts { (posts, error) in
                            if let posts = posts {
                                savePostsToCoreData(posts: posts)
                                print("Próbuję pobrać nowe dane")
                            }
                        }
                    }) {
                        HStack {
                            Text(dataService.isLoading ? "Ładowanie..." : "Wczytaj więcej")
                                .foregroundColor(Color("fontDark"))
                                .font(.custom("SantanderText-Normal", size: 14))
                            Image(systemName: "arrow.right")
                                .renderingMode(.template)
                                .foregroundColor(Color("santanderRed"))
                        }
                        .frame(width: 280, height: 46)
                        .background(Color.white)
                        .border(Color(red: 0.87, green: 0.93, blue: 0.95))
                    }
                    .disabled(dataService.isLoading)
                }
            }
            .padding()
            .overlay(
                Group {
                    if dataService.currentStatus != .upToDate && dataService.currentStatus != .idle {
                        StatusView(status: dataService.currentStatus)
                            .transition(.move(edge: .top))
                    }
                },
                alignment: .top
            )
            .animation(.default, value: dataService.currentStatus)
        }
    }
}

struct ProjectList_Previews: PreviewProvider {
    static var previews: some View {
        ProjectList()
    }
}
