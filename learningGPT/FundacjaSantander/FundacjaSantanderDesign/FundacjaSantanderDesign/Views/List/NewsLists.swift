//
//  NewsLists.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 29/05/2023.
//

import SwiftUI
import CoreData

struct NewsLists: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: Post.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Post.date, ascending: false)],
        animation: .default)
    private var posts: FetchedResults<Post>
    
    var body: some View {
        VStack {
            CountPost(countPost: countCategoryEightPosts(), postUpdated: 0, postThumb: 0) // Tutaj używamy komponentu CountPost
            LazyVStack {
                ForEach(posts, id: \.self) { post in
                    if isCategoryEight(post: post) {
                        let newsItem = NewsItem(imageData: post.postToThumb?.imageData,
                                                title: post.title ?? "",
                                                content: post.content ?? "",
                                                datePublication: formattedDateDayMontYear(from: post.date ?? Date()))
                        NavigationLink(destination: PostDetailView(post: post)) {
                            getNewsItemView(newsItem: newsItem)
                        }
                    }
                }
            }
        }
    }
    
    private func isCategoryEight(post: Post) -> Bool {
        if let categoryArray = post.categories as? [Int] {
            return categoryArray.contains(8)
        }
        return false
    }

    private func countCategoryEightPosts() -> Int {
        return posts.filter { isCategoryEight(post: $0) }.count
    }

    private func getNewsItemView(newsItem: NewsItem) -> some View {
        newsItem
            .padding(.top)
    }
}

struct NewsLists_Previews: PreviewProvider {
    static var previews: some View {
        NewsLists()
    }
}




