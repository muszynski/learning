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
    
    var body: some View {
        List {
            ForEach(posts, id: \.self) { post in
                VStack(alignment: .leading) {
                    ProjectItem(
                        imageData: post.thumbnailsImage,
                        title: post.title ?? "Title",
                        content: post.content ?? "Content",
                        categoryName: getCategoryNames(from: post.categories).joined(separator: ", "),
                        link: post.link ?? defaultLink
                    )
                }
            }
            
            if dataService.hasMorePages {
                Button(action: {
                    dataService.fetchMorePosts { (posts, error) in
                        if let posts = posts {
                            savePostsToCoreData(posts: posts)
                        }
                    }
                }) {
                    Text("Load More Posts")
                }
                .disabled(dataService.isLoading)
                
            }
        }
    }
}

struct ProjectList_Previews: PreviewProvider {
    static var previews: some View {
        ProjectList()
    }
}

