//
//  PostQuery.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 23/05/2023.
//

import Foundation
import CoreData

class PostQuery : ObservableObject {
    
    var totalPosts: Int = 0
    var postsPerPage: Int = 10 // zainicjuj z domyślną wartością
    var context = PersistenceController.shared.container.viewContext
    var wordpressApi = WordPressAPI() // Załóżmy, że WordPressAPI jest dostępne i zainicjalizowane.
    
    // funkcja pobierajaca informacje i ilosci postow oraz o ilosc stron
    func getWPHeaders(from response: URLResponse?) -> (total: Int?, totalPages: Int?) {
        guard let httpResponse = response as? HTTPURLResponse else {
            return (nil, nil)
        }
        
        let total = httpResponse.allHeaderFields["X-WP-Total"] as? String
        let totalPages = httpResponse.allHeaderFields["X-WP-TotalPages"] as? String
        
        return (Int(total ?? ""), Int(totalPages ?? ""))
    }
    
    // funkcja generujaca url wedlug parametrow jakie otrzymuje, id, post per page, page number
    func createUrl(id: Int? = nil, postsPerPage: Int? = nil, pageNumber: Int? = nil) -> URL? {
        var urlComponents = URLComponents(string: defaultLink + "/wp-json/wp/v2/posts")
        
        let parameters: [(String, Int?)] = [("categories", id), ("per_page", postsPerPage), ("page", pageNumber)]
        urlComponents?.queryItems = parameters.compactMap { pair in
            guard let value = pair.1 else { return nil }
            return URLQueryItem(name: pair.0, value: "\(value)")
        }
        return urlComponents?.url
    }

    // funkcja obliczajaca ilosc wywolan do API jakie musza byc wykonane
    func calculateNumberOfRequests(totalPosts: Int, postsPerPage: Int) -> Int {
        let remainder = totalPosts % postsPerPage
        let quotient = totalPosts / postsPerPage
        
        return remainder == 0 ? quotient : quotient + 1
    }
    
    // funkcja wywołująca ilość zadań API w zależności od ilości postów
    func fetchAllPostsInBackground() {
        let totalRequests = calculateNumberOfRequests(totalPosts: totalPosts, postsPerPage: postsPerPage)

        for currentPage in 1...totalRequests {
            fetchAndSavePosts(pageNumber: currentPage)
        }
    }
    
    func arePostsStoredInCoreData() -> Bool {
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()

        do {
            let postsCount = try context.count(for: fetchRequest)
            return postsCount > 0
        } catch {
            print("Failed to fetch posts:", error)
            return false
        }
    }
    
    func fetchNewPostsAndSaveToCoreData() {
        fetchAllPostsInBackground()
    }
    
    func fetchAndSavePosts(pageNumber: Int) {
        // Pobranie danych z API.
        wordpressApi.fetchPosts(pageNumber: pageNumber) { (result: Result<[WordpressPost], NetworkError>) in
            switch result {
            case .success(let posts):
                // Zapisanie pobranych danych do Core Data.
                savePostsToCoreData(posts: posts) { error in
                    if let error = error {
                        print("Failed to save posts:", error)
                    } else {
                        print("Posts saved successfully.")
                    }
                }
            case .failure(let error):
                print("Failed to fetch posts:", error)
            }
        }
    }



    // Metoda isPostStoredInCoreData() musi być zdefiniowana w klasie PostQuery.
    func isPostStoredInCoreData(postId: Int) -> Bool {
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "idPost == %@", NSNumber(value: postId))

        do {
            let posts = try context.fetch(fetchRequest)
            return !posts.isEmpty
        } catch {
            print("Failed to fetch posts:", error)
            return false
        }
    }
}
