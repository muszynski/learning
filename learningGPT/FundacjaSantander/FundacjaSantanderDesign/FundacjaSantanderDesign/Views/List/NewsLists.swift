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
    @ObservedObject var postQuery = PostQuery() // dodanie obserwowania postQuery
    
    @FetchRequest(
        entity: Post.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Post.date, ascending: false)],
        animation: .default)
    private var posts: FetchedResults<Post>
    
    var body: some View {
        VStack {
//            CountPost(countPost: countCategoryEightPosts(), postUpdated: 0, postThumb: 0) // Tutaj używamy komponentu CountPost
            ScrollView {
                LazyVStack {
                    ForEach(posts.indices, id: \.self) { index in
                        let post = posts[index]
                        let newsItem = NewsItem(imageData: post.postToThumb?.imageData,
                                                title: post.title ?? "",
                                                content: post.content ?? "",
                                                datePublication: formattedDateDayMontYear(from: post.date ?? Date()))
                        NavigationLink(destination: PostDetailView(post: post)) {
                            getNewsItemView(newsItem: newsItem)
                        }
                        // Wywołanie fetchNextPage gdy ostatni post stanie się widoczny
                        if posts.last == post {
                            Divider().onAppear {
                                postQuery.fetchNextPage(categories: newsCategory, postsPerPage: postPerPage) { error in
                                    if let error = error {
                                        print("Error fetching next page: \(error)")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .background(Color("bgGray"))
        .onAppear {
            postQuery.fetchNextPage(categories: newsCategory, postsPerPage: postPerPage) { error in
                if let error = error {
                    print("Error fetching first page: \(error)")
                }
            }
        }
    }

    private func getNewsItemView(newsItem: NewsItem) -> some View {
        newsItem
            .padding(.top)
    }
//    private func countCategoryEightPosts() -> Int {
//        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "category == %@", "8")
//
//        do {
//            let count = try viewContext.count(for: fetchRequest)
//            return count
//        } catch {
//            print("Error counting posts: \(error)")
//            return 0
//        }
//    }

}

struct NewsLists_Previews: PreviewProvider {
    static var previews: some View {
        NewsLists()
    }
}
