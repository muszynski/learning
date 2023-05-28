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
    let postsQuery = PostQuery()
    let imageProcessor = ImageProcessor()
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchAndUpdateData(postsPerPage: Int, completion: @escaping (Error?) -> Void) {
        postsQuery.fetchWPHeaders { [weak self] error in
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

                self?.fetchAndUpdatePosts(postsPerPage: postsPerPage) { error in
                    if let error = error {
                        print("Failed to fetch and update posts: \(error.localizedDescription)")
                        completion(error)
                    } else {
                        self?.fetchAndSaveThumbnails { error in
                            if let error = error {
                                print("Failed to fetch and save thumbnails: \(error.localizedDescription)")
                            }
                            print("Posts and thumbnails updated successfully.")
                            completion(nil)
                        }
                    }
                }
            }
        }
    }

    
    // Usunięto fetchAndSaveCategories

    private func fetchAndUpdatePosts(postsPerPage: Int, completion: @escaping (Error?) -> Void) {
        postsQuery.fetchNewPostsAndSaveToCoreData(postsPerPage: postsPerPage) { error in
            if let error = error {
                print("Failed to fetch and update posts: \(error.localizedDescription)")
                completion(error)
            } else {
                print("Posts updated successfully.")
                completion(nil)
            }
        }
    }

    private func fetchAndSaveThumbnails(completion: @escaping (Error?) -> Void) {
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()

        do {
            let posts = try context.fetch(fetchRequest)
            for post in posts {
                if let thumbnailUrl = post.thumbnails {
                    imageProcessor.fetchAndSaveThumbnail(thumbnail: thumbnailUrl, postId: Int(post.idPost), context: context, completion: completion)
                }
            }
        } catch {
            print("Failed to fetch posts: \(error.localizedDescription)")
            completion(error)
        }
    }
    
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




//    private func fetchAndSaveCategories(completion: @escaping (Error?) -> Void) {
//        categoriesService.fetchAndSaveCategories { error in
//            if let error = error {
//                print("Failed to fetch and save categories: \(error.localizedDescription)")
//                completion(error)
//            } else {
//                print("Categories saved successfully.")
//                completion(nil)
//            }
//        }
//    }
