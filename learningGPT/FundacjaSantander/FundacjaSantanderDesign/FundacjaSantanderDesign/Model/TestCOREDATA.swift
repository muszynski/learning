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
    
    @State private var categoryMap: [Int16: String] = [:]

    var body: some View {
        List {
            ForEach(posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title ?? "No title")
                    Text(post.excerpt ?? "No excerpt")
                    Text(post.thumbnails ?? "No link")
                    ImageHolder(imageData: post.thumbnailsImage)
                    
                    // Displaying the categories of each post
                    if let categories = post.categories as? [Int16] {
                        ForEach(categories, id: \.self) { categoryId in
                            if let categoryName = categoryMap[categoryId] {
                                Text(categoryName)
                            }
                        }
                    }
                }
            }

            // Displaying the contents of categoryMap
            ForEach(Array(categoryMap.keys), id: \.self) { key in
                if let value = categoryMap[key] {
                    Text("\(key): \(value)")
                }
            }
        }
        .onAppear {
            DataService().fetchAndSavePosts()
            DataService().fetchAndSaveCategories()
            categoryMap = DataService().loadCategoriesFromCoreData()
        }
    }
}

struct TestCOREDATA_Previews: PreviewProvider {
    static var previews: some View {
        let mockPost = Post(context: PersistenceController.preview.container.viewContext)
        mockPost.title = "Sample Title"
        mockPost.excerpt = "Sample Excerpt"
        mockPost.thumbnails = "Sample Link"
        mockPost.categories = [1, 2] as NSArray
        
        let mockCategoryMap: [Int16: String] = [1: "Category 1", 2: "Category 2"]
        
        return TestCOREDATA()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .previewDisplayName("Preview")
    }
}
