//
//  DataService.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 19/05/2023.
//

import Foundation

class DataService {
    func fetchPosts(completion: @escaping ([WordpressPost]?) -> Void) {
        let url = URL(string: "https://fundacja.santander.pl/wp-json/wp/v2/posts")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil)
                return
            }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(customISO8601DateFormatter())
            if let posts = try? decoder.decode([WordpressPost].self, from: data) {
                completion(posts)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    

    func fetchCategories(completion: @escaping ([Category]?) -> Void) {
        let url = URL(string: "https://fundacja.santander.pl/wp-json/wp/v2/categories")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil)
                return
            }

            let decoder = JSONDecoder()
            if let categories = try? decoder.decode([Category].self, from: data) {
                completion(categories)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchAndSavePosts() {
            fetchPosts { posts in
                if let posts = posts {
                    savePostsToCoreData(posts: posts)
                }
            }
        }

        func fetchAndSaveCategories() {
            fetchCategories { categories in
                if let categories = categories {
                    saveCategoriesToCoreData(categories: categories)
                }
            }
        }
    
}

