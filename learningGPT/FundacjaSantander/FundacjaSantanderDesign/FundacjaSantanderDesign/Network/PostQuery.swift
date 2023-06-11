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
    var totalPages: Int = 0
    var postsPerPage: Int = 20
    var context = PersistenceController.shared.container.viewContext
    var wordpressApi = WordPressAPI()
    let imageProcessor = ImageProcessor()
    
    func fetchWPHeaders(completion: @escaping (Error?) -> Void) {
        // Replace with your actual API URL
        let url = URL(string: defaultLink + "/wp-json/wp/v2/posts")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("URLSession error: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP response status code: \(httpResponse.statusCode)")
                print("HTTP response headers: \(httpResponse.allHeaderFields)")
            }
            
            let headers = self.getWPHeaders(from: response)
            self.totalPosts = headers.total ?? 1
            self.totalPages = headers.totalPages ?? 1
            
            completion(nil)
        }
        
        task.resume()
    }
    
    
    
    
    // funkcja pobierajaca informacje i ilosci postow oraz o ilosc stron
    func getWPHeaders(from response: URLResponse?) -> (total: Int?, totalPages: Int?) {
        guard let httpResponse = response as? HTTPURLResponse else {
            return (nil, nil)
        }
        
        let total = httpResponse.allHeaderFields["x-wp-total"] as? String
        let totalPages = httpResponse.allHeaderFields["x-wp-totalpages"] as? String
        
        return (Int(total ?? "1"), Int(totalPages ?? "1"))
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
    func fetchAllPostsInBackground(postsPerPage: Int, completion: @escaping ([WordpressPost]?, Error?) -> Void) {
        let totalRequests = calculateNumberOfRequests(totalPosts: totalPosts, postsPerPage: postsPerPage)
        var allPosts: [WordpressPost] = []
        var error: Error?
        
        for currentPage in 1...totalRequests {
            fetchAndSavePosts(pageNumber: currentPage) { (posts, fetchError) in
                if let fetchError = fetchError {
                    print("Failed to fetch posts:", fetchError)
                    error = fetchError
                    completion(nil, error)
                } else if let posts = posts {
                    let newPosts = posts.filter { !self.isPostStoredInCoreData(postId: Int($0.id)) }
                    allPosts.append(contentsOf: newPosts)
                }
                
                if currentPage == totalRequests {
                    completion(allPosts, nil)
                }
            }
        }
    }

    // Ta metoda sprawdza, czy są już jakieś posty zapisane w Core Data.
    func arePostsStoredInCoreData() -> Bool {
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
        
        do {
            let posts = try context.fetch(fetchRequest)
            return !posts.isEmpty
        } catch {
            print("Failed to fetch posts:", error)
            return false
        }
    }
    
    func fetchNewPostsAndSaveToCoreData(postsPerPage: Int, completion: @escaping (Error?) -> Void) {
        fetchAllPostsInBackground(postsPerPage: postsPerPage) { (posts, error) in
            if let error = error {
                print("Failed to fetch or save posts: \(error)")
                completion(error)
            } else {
                print("Fetched and saved \(posts?.count ?? 0) posts.")
                completion(nil)
            }
        }
    }

    func fetchAndSavePosts(pageNumber: Int, completion: @escaping ([WordpressPost]?, Error?) -> Void) {
        wordpressApi.fetchPosts(pageNumber: pageNumber) { (result: Result<([WordpressPost], URLResponse?), NetworkError>) in
            switch result {
            case .success(let (posts, _)):
                savePostsToCoreData(posts: posts) { error in
                    if let error = error {
                        print("Failed to save posts on page \(pageNumber):", error)
                        completion(nil, error)
                        return
                    } else {
                        print("Posts on page \(pageNumber) saved successfully. Total posts: \(posts.count)")
                    }

                    let group = DispatchGroup()

                    for post in posts {
                        group.enter()
                        print("Fetching thumbnail for post with id \(post.id) from URL: \(post.thumbnails)") // Dodajemy log tutaj
                        self.imageProcessor.fetchAndSaveThumbnail(thumbnail: post.thumbnails, postId: Int(post.id), context: self.context) { error in
                            if let error = error {
                                print("Failed to fetch and save thumbnail for post with id \(post.id): \(error)")
                            } else {
                                print("Thumbnail for post with id \(post.id) fetched and saved successfully.")
                            }
                            group.leave()
                        }
                    }

                    group.notify(queue: .main) {
                        print("All thumbnails fetched and saved.")
                        completion(posts, nil)
                    }
                }
            case .failure(let error):
                print("Failed to fetch posts on page \(pageNumber):", error)
                completion(nil, error)
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
