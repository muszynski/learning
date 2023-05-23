//
//  TestCOREDATA.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 19/05/2023.
//

//import SwiftUI
//import CoreData
//
//struct TestCOREDATA: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Post.date, ascending: true)],
//        animation: .default)
//    private var posts: FetchedResults<Post>
//    
//    @State private var categoryMap: [Int16: String] = [:]
//    @StateObject private var postService = PostService()
//    @StateObject private var categoryService = CategoriesService()
//
//    var body: some View {
//        VStack {
//            List {
//                ForEach(posts.indices, id: \.self) { index in
//                    VStack(alignment: .leading) {
//                        Text("\(index + 1). \(posts[index].title ?? "No title")")
//                        Text(posts[index].excerpt ?? "No excerpt")
//                        
//                        // Displaying the categories of each post
//                        if let categories = posts[index].categories as? [Int16] {
//                            ForEach(categories, id: \.self) { categoryId in
//                                if let categoryName = categoryMap[categoryId] {
//                                    Text(categoryName)
//                                }
//                            }
//                        }
//                    }
//                }
//
//                // Displaying the contents of categoryMap
//                ForEach(Array(categoryMap.keys), id: \.self) { key in
//                    if let value = categoryMap[key] {
//                        Text("\(key): \(value)")
//                    }
//                }
//            }
//            
//            Button(action: {
//                postService.fetchPosts()
//                    .sink(receiveCompletion: { completion in
//                        switch completion {
//                        case .failure(let error):
//                            print("Error: \(error.localizedDescription)")
//                        case .finished:
//                            break
//                        }
//                    }, receiveValue: { _ in
//                        categoryMap = categoryService.loadCategoriesFromCoreData()
//                    })
//                    .store(in: &postService.cancellables)
//            }) {
//                Text("Pobierz więcej postów")
//            }
//            .disabled(postService.isLoading || !postService.hasMorePages)
//
//        }
//        .onAppear {
//            categoryService.fetchAndSaveCategories()
//                .flatMap { _ in
//                    postService.fetchAndSavePosts()
//                }
//                .sink(receiveCompletion: { completion in
//                    switch completion {
//                    case .failure(let error):
//                        print("Error: \(error.localizedDescription)")
//                    case .finished:
//                        break
//                    }
//                }, receiveValue: { _ in
//                    categoryMap = categoryService.loadCategoriesFromCoreData()
//                })
//                .store(in: &categoryService.cancellables)
//        }
//
//    }
//}
//
//
//struct TestCOREDATA_Previews: PreviewProvider {
//    static var previews: some View {
//        let mockPost = Post(context: PersistenceController.preview.container.viewContext)
//        mockPost.title = "Sample Title"
//        mockPost.excerpt = "Sample Excerpt"
//        mockPost.thumbnails = "Sample Link"
//        mockPost.categories = [1, 2] as NSArray
//        
//        // let mockCategoryMap: [Int16: String] = [1: "Category 1", 2: "Category 2"]
//        
//        return TestCOREDATA()
//            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//            .previewDisplayName("Preview")
//    }
//}
