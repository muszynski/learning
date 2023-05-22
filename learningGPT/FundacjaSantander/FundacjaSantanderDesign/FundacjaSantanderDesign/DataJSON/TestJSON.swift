//
//  TestJSON.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 19/05/2023.
//

import SwiftUI

struct PostsView: View {
    @State private var posts: [WordpressPost] = []
    @StateObject private var postService = PostService()
    
    var body: some View {
        List(posts, id: \.id) { post in
            Text(post.title.rendered)
        }
        .onAppear(perform: loadPosts)
    }
    
    func loadPosts() {
        let cancellable = postService.fetchPosts()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { fetchedPosts in
                DispatchQueue.main.async {
                    self.posts = fetchedPosts
                }
            })
        
        postService.cancellables.insert(cancellable)
    }
}
struct CategoriesView: View {
    @State private var categories: [Category] = []
    private var categoryService = CategoriesService()
    
    var body: some View {
        List(categories, id: \.id) { category in
            Text(category.name)
        }
        .onAppear(perform: loadCategories)
    }
    
    func loadCategories() {
        categoryService.fetchCategories()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { fetchedCategories in
                DispatchQueue.main.async {
                    self.categories = fetchedCategories
                }
            })
            .store(in: &categoryService.cancellables)
    }
}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
