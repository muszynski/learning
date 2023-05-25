//
//  SimpleTest.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 21/05/2023.
//


//import SwiftUI
//
//struct SimpleTest: View {
//    @ObservedObject var dataService = PostService()
//    @State private var posts: [WordpressPost] = []
//
//    var body: some View {
//        VStack {
//            List(posts.indices, id: \.self) { index in
//                Text("\(index + 1). \(posts[index].title.rendered)")
//            }
//
//            Button(action: {
//                fetchPosts()
//            }) {
//                Text("Load more posts")
//            }
//        }
//        .onAppear(perform: fetchPosts)
//    }
//
//    private func fetchPosts() {
//        dataService.fetchPosts()
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .failure(let error):
//                    print("Failed to fetch posts: \(error)")
//                case .finished:
//                    break
//                }
//            }, receiveValue: { newPosts in
//                DispatchQueue.main.async {
//                    self.posts.append(contentsOf: newPosts)
//                }
//            })
//            .store(in: &dataService.cancellables)
//    }
//
//}
//
//
//struct SimpleTest_Previews: PreviewProvider {
//    static var previews: some View {
//        SimpleTest()
//    }
//}
