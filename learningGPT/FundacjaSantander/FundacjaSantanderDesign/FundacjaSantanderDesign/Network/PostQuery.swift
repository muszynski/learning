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
        var currentPage: Int = 1  // dodanie currentPage
        var context = PersistenceController.shared.container.viewContext
        var wordpressApi = WordPressAPI()
        let imageProcessor = ImageProcessor()
        @Published var fetchedPostsCount: Int = 0
    
    
    func fetchNextPage(categories: [Int], postsPerPage: Int, completion: @escaping (Error?) -> Void) {
            fetchAndSavePosts(categories: categories, pageNumber: currentPage) { [weak self] (posts, error) in
                if let error = error {
                    print("Failed to fetch or save posts: \(error)")
                    completion(error)
                } else {
                    print("Fetched and saved \(posts?.count ?? 0) posts.")
                    self?.currentPage += 1  // inkrementacja currentPage po pobraniu strony
                    completion(nil)
                }
            }
        }
    
    func fetchWPHeaders(categories: [Int], completion: @escaping (Error?) -> Void) {
        guard let url = createUrl(categories: categories, postsPerPage: postPerPage) else {
            completion(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "URL could not be created"]))
            return
        }
        
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
    func createUrl(categories: [Int]? = nil, postsPerPage: Int? = nil, pageNumber: Int? = nil) -> URL? {
        var urlComponents = URLComponents(string: defaultLink + "/wp-json/wp/v2/posts")
        
        var queryItems = [URLQueryItem]()
        
        if let categories = categories {
            let categoryString = categories.map(String.init).joined(separator: ",")
            queryItems.append(URLQueryItem(name: "categories", value: categoryString))
        }
        
        if let postsPerPage = postsPerPage {
            queryItems.append(URLQueryItem(name: "per_page", value: "\(postsPerPage)"))
        }
        
        if let pageNumber = pageNumber {
            queryItems.append(URLQueryItem(name: "page", value: "\(pageNumber)"))
        }
        
        urlComponents?.queryItems = queryItems
        
        return urlComponents?.url
    }
    
    
    // funkcja obliczajaca ilosc wywolan do API jakie musza byc wykonane
    func calculateNumberOfRequests(totalPosts: Int, postsPerPage: Int) -> Int {
        let remainder = totalPosts % postsPerPage
        let quotient = totalPosts / postsPerPage
        
        return remainder == 0 ? quotient : quotient + 1
    }
    
    // funkcja wywołująca ilość zadań API w zależności od ilości postów
    func fetchAllPostsInBackground(categories: [Int], postsPerPage: Int, completion: @escaping ([WordpressPost]?, Error?) -> Void) {
        fetchWPHeaders(categories: categories) { [weak self] error in
            guard let strongSelf = self else {
                completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Self is nil"]))
                return
            }
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            let totalRequests = strongSelf.calculateNumberOfRequests(totalPosts: strongSelf.totalPosts, postsPerPage: postsPerPage)
            var allPosts: [WordpressPost] = []
            var error: Error?
            
            for currentPage in 1...totalRequests {
                strongSelf.fetchAndSavePosts(categories: categories, pageNumber: currentPage) { (posts, fetchError) in
                    if let fetchError = fetchError {
                        print("Failed to fetch posts:", fetchError)
                        error = fetchError
                        completion(nil, error)
                    } else if let posts = posts {
                        let newPosts = posts.filter { !strongSelf.isPostStoredInCoreData(postId: Int($0.id)) }
                        allPosts.append(contentsOf: newPosts)
                    }
                    
                    if currentPage == totalRequests {
                        completion(allPosts, nil)
                    }
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
    
    func fetchNewPostsAndSaveToCoreData(categories: [Int], postsPerPage: Int, completion: @escaping (Error?) -> Void) {
        fetchAllPostsInBackground(categories: categories, postsPerPage: postsPerPage) { (posts, error) in
            if let error = error {
                print("Failed to fetch or save posts: \(error)")
                completion(error)
            } else {
                print("Fetched and saved \(posts?.count ?? 0) posts.")
                completion(nil)
            }
        }
    }

    
    func fetchAndSavePosts(categories: [Int], pageNumber: Int, completion: @escaping ([WordpressPost]?, Error?) -> Void) {
        wordpressApi.fetchPosts(categories: categories, pageNumber: pageNumber) { (result: Result<([WordpressPost], URLResponse?), NetworkError>) in
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
                        self.imageProcessor.fetchAndSaveThumbnail(thumbnail: post.thumbnails, postId: Int(post.id), context: self.context) { error in
                            if let error = error {
                                print("Failed to fetch and save thumbnail for post with id \(post.id): \(error)")
                            } else {
                                print("Thumbnail for post with id \(post.id) fetched and saved successfully.")
                                DispatchQueue.main.async {
                                    self.fetchedPostsCount += 1 // Aktualizacja ilości pobranych postów
                                }
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

    
    // Sprawdzenie czy post jest już w CoreData.
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
