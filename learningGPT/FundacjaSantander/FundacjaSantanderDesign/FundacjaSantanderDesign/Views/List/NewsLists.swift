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

    @State private var showSafariView = false // State variable to control SafariView presentation
    @State private var selectedLink: URL? = nil // State variable to hold selected link
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(posts.filter { post in
                    if let categoryArray = post.categories as? [Int] {
                        return categoryArray.contains(8)
                    }
                    return false
                }, id: \.self) { post in
                    if let thumb = post.postToThumb, let imageData = thumb.imageData {
                        if let date = post.date {
                            let formattedDate = formattedDateDayMontYear(from: date)
                            let newsItem = NewsItem(imageData: imageData,
                                                    title: post.title ?? "",
                                                    content: post.content ?? "")
                            getNewsItemView(newsItem: newsItem, post: post)
                        }
                    }
                }
            }
        }
    }
    
    private func getNewsItemView(newsItem: NewsItem, post: Post) -> some View {
        newsItem
            .padding(.top)
            .onTapGesture {
                selectedLink = URL(string: post.link ?? "")
                showSafariView = true
            }
            .sheet(isPresented: $showSafariView) {
                SafariView(url: selectedLink ?? URL(string: "https://fundacja.santander.pl")!) // Example URL as fallback
            }
    }
}


struct NewsLists_Previews: PreviewProvider {
    static var previews: some View {
        NewsLists()
    }
}
