//
//  TestJSON.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 19/05/2023.
//

import SwiftUI

struct PostsView: View {
    @State private var posts: [WordpressPost] = []
    private var dataService = DataService()
    
    var body: some View {
        List(posts, id: \.id) { post in
            Text(post.title.rendered)
        }
        .onAppear(perform: loadPosts)
    }
    
    func loadPosts() {
        dataService.fetchPosts { fetchedPosts, error in
            guard let fetchedPosts = fetchedPosts else {
                // Możesz tutaj obsłużyć błąd, jeśli chcesz
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            DispatchQueue.main.async {
                self.posts = fetchedPosts
            }
        }
    }

}

struct CategoriesView: View {
    @State private var categories: [Category] = []
    private var dataService = DataService()
    
    var body: some View {
        List(categories, id: \.id) { category in
            Text(category.name)
        }
        .onAppear(perform: loadCategories)
    }

    func loadCategories() {
        dataService.fetchCategories { fetchedCategories, error in
            guard let fetchedCategories = fetchedCategories else {
                // Możesz tutaj obsłużyć błąd, jeśli chcesz
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            DispatchQueue.main.async {
                self.categories = fetchedCategories
            }
        }
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
