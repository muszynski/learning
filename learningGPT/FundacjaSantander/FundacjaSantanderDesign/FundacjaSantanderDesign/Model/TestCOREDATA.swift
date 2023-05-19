//
//  TestCOREDATA.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 19/05/2023.
//

import SwiftUI
import CoreData

struct TestCOREDATA: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Post.date, ascending: true)],
        animation: .default)
    private var posts: FetchedResults<Post>

    var body: some View {
        List {
            ForEach(posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title ?? "No title")
                    Text(post.excerpt ?? "No excerpt")
                }
            }
        }
        .onAppear {
            DataService().fetchAndSavePosts()
            DataService().fetchAndSaveCategories()
        }
    }
}



struct TestCOREDATA_Previews: PreviewProvider {
    static var previews: some View {
        TestCOREDATA()
    }
}
