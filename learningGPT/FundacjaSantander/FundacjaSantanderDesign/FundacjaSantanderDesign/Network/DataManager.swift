//
//  DataManager.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 24/05/2023.
//

import Foundation
import CoreData

class DataManager : ObservableObject {
    
    let context: NSManagedObjectContext
    let categoriesService = CategoriesService()
    let postsQuery: PostQuery
    let imageProcessor = ImageProcessor()
    let faqAPI = WordPressAPI()
    let faqService = FaqService()
    
    init(context: NSManagedObjectContext, postQuery: PostQuery) {
        self.context = context
        self.postsQuery = postQuery
    }
    
    func fetchAndUpdateData(postsPerPage: Int, completion: @escaping (Error?) -> Void) {
        postsQuery.fetchWPHeaders(categories: newsCategory) { [weak self] error in // używamy newsCategory
            if let error = error {
                print("Failed to fetch WP headers: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            self?.categoriesService.fetchAndSaveAllCategories { error in
                if let error = error {
                    print("Failed to fetch and save categories: \(error.localizedDescription)")
                    completion(error)
                    return
                }
                
                self?.fetchAndUpdatePosts(postsPerPage: postsPerPage, categories: newsCategory ) { error in // używamy newsCategory
                    if let error = error {
                        print("Failed to fetch and update posts: \(error.localizedDescription)")
                        completion(error)
                        return
                    }

                    // Dodajemy pobieranie projektów
                    self?.fetchAndUpdatePosts(postsPerPage: postsPerPage, categories: projectCategory ) { error in // używamy projectCategory
                        if let error = error {
                            print("Failed to fetch and update projects: \(error.localizedDescription)")
                            completion(error)
                            return
                        }
                    
                        self?.faqService.fetchAndSaveAllFaqs { error in
                            if let error = error {
                                print("Failed to fetch and save FAQs: \(error.localizedDescription)")
                                completion(error)
                                return
                            }
                            
                            print("Posts, Projects and FAQs updated successfully.")
                            completion(nil)
                        }
                    }
                }
            }
        }
    }

    private func fetchAndUpdatePosts(postsPerPage: Int, categories: [Int], completion: @escaping (Error?) -> Void) {
        postsQuery.fetchNewPostsAndSaveToCoreData(categories: categories, postsPerPage: postsPerPage) { error in // dodajemy parametr categories
            if let error = error {
                print("Failed to fetch and update posts: \(error.localizedDescription)")
                completion(error)
            } else {
                print("Posts updated successfully.")
                completion(nil)
            }
        }
    }
    
    private var lastProcessedPostId: Int = 0
    
    func checkIfDataLoaded() -> Bool {
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Failed to fetch posts count: \(error)")
            return false
        }
    }
}
