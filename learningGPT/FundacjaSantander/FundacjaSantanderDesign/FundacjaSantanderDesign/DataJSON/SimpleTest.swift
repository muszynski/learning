//
//  SimpleTest.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 21/05/2023.
//


import SwiftUI

struct SimpleTest: View {
    @ObservedObject var dataService = DataService()
    @State private var posts: [WordpressPost] = []
    
    var body: some View {
        VStack {
            List(posts.indices, id: \.self) { index in
                Text("\(index + 1). \(posts[index].title.rendered)")
            }
            
            Button(action: {
                fetchPosts()
            }) {
                Text("Load more posts")
            }
        }
        .onAppear(perform: fetchPosts)
    }
    
    private func fetchPosts() {
        dataService.fetchMorePosts { newPosts, error in
            if let error = error {
                print("Failed to fetch posts:", error)
            } else if let newPosts = newPosts {
                DispatchQueue.main.async {
                    self.posts.append(contentsOf: newPosts)
                }
            }
        }
    }
}


struct SimpleTest_Previews: PreviewProvider {
    static var previews: some View {
        SimpleTest()
    }
}
