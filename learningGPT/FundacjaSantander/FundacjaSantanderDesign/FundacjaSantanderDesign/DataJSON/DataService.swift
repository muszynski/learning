//
//  DataService.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 19/05/2023.
//

import Foundation
import CoreData
import Combine

class DataService: ObservableObject {
    @Published var currentPage: Int = 1
    @Published var isLoading: Bool = false
    @Published var hasMorePages: Bool = true
    let postsPerPage: Int = 50 // limit pobran z API
    
    func fetchPosts(completion: @escaping ([WordpressPost]?) -> Void) {
        let url = URL(string: "https://fundacja.santander.pl/wp-json/wp/v2/posts?per_page=\(postsPerPage)&page=\(currentPage)")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil)
                return
            }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(customISO8601DateFormatter())
            if let posts = try? decoder.decode([WordpressPost].self, from: data) {
                self.currentPage += 1 // zwiększamy licznik strony
                completion(posts)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    
    func fetchCategories(completion: @escaping ([Category]?) -> Void) {
        let url = URL(string: "https://fundacja.santander.pl/wp-json/wp/v2/categories?per_page=100")!
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
    
    // funkcja ktora pobiera wiecej postow po wywolaniu
    
    func fetchMorePosts(completion: @escaping ([WordpressPost]?, Error?) -> Void) {
           isLoading = true
           let url = URL(string: "https://fundacja.santander.pl/wp-json/wp/v2/posts?per_page=\(postsPerPage)&page=\(currentPage)")!
           let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
               guard let data = data else {
                   completion(nil, error)
                   self.isLoading = false
                   return
               }
               
               let decoder = JSONDecoder()
               decoder.dateDecodingStrategy = .formatted(customISO8601DateFormatter())
               if let posts = try? decoder.decode([WordpressPost].self, from: data) {
                   DispatchQueue.main.async {
                       self.currentPage += 1
                       self.hasMorePages = !posts.isEmpty
                       self.isLoading = false
                   }
                   completion(posts, nil)
               } else {
                   DispatchQueue.main.async {
                       self.isLoading = false
                   }
                   completion(nil, nil)
               }
           }
           task.resume()
       }
    // funkcja tworzaca z kategori słownik
    
    func loadCategoriesFromCoreData() -> [Int16: String] {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Categories> = Categories.fetchRequest()
        
        do {
            let categories = try context.fetch(fetchRequest)
            var categoryMap = [Int16: String]()
            for category in categories {
                categoryMap[category.idCategory] = category.name
            }
            return categoryMap
        } catch let error as NSError {
            print("Could not fetch categories. \(error), \(error.userInfo)")
            return [:]
        }
    }
    
   }
    


