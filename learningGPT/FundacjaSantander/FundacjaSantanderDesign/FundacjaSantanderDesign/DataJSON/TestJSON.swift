//
//  TestJSON.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 19/05/2023.
//

import SwiftUI

struct TestJSON: View {
    @ObservedObject private var wordpressAPI = WordPressAPI()

    var body: some View {
        List(wordpressAPI.posts.indices, id: \.self) { index in
            Text("\(index + 1). \(wordpressAPI.posts[index].title.rendered)")
        }
        .onAppear {
            print("Przed pobraniem postów: \(wordpressAPI.posts)")
            
            wordpressAPI.fetchPosts(pageNumber: 1) { result in
                switch result {
                case .success(let posts):
                    DispatchQueue.main.async {
                        wordpressAPI.posts = posts
                    }
                    print("Po pobraniu postów: \(wordpressAPI.posts)")
                case .failure(let error):
                    print("Błąd pobierania postów: \(error)")
                }
            }
        }
    }
}


struct TestJSON_Previews: PreviewProvider {
    static var previews: some View {
        TestJSON()
    }
}

