//
//  SaveCoreData.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 19/05/2023.
//
//


import CoreData

func savePostsToCoreData(posts: [WordpressPost], completion: @escaping (Error?) -> Void) {
    let context = PersistenceController.shared.container.viewContext
    context.perform {
        for post in posts {
            let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "idPost == %@", NSNumber(value: post.id))
            
            do {
                let fetchedPosts = try context.fetch(fetchRequest)
                
                var newPost: Post!
                if let existingPost = fetchedPosts.first {
                    let serverModifiedDate = customISO8601DateFormatter().date(from: post.modified)
                    if serverModifiedDate?.compare(existingPost.modified!) == .orderedDescending {
                        newPost = existingPost
                    } else {
                        continue
                    }
                } else {
                    newPost = Post(context: context)
                    newPost.idPost = Int16(post.id)
                }
                
                newPost.date = customISO8601DateFormatter().date(from: post.date)
                newPost.modified = customISO8601DateFormatter().date(from: post.modified)
                newPost.slug = post.slug
                newPost.status = post.status
                newPost.type = post.type
                newPost.link = post.link
                newPost.title = post.title.rendered
                newPost.content = post.content.rendered
                newPost.excerpt = post.excerpt.rendered
                newPost.categories = post.categories as NSArray? ?? []
                // Debugowanie
                if let categories = newPost.categories as? [NSNumber] {
                    print("Categories for post \(post.id): \(categories)")
                } else {
                    print("Could not convert categories for post \(post.id) to [NSNumber]")
                }
                newPost.tags = post.tags as NSArray? ?? []
                newPost.thumbnails = post.thumbnails.stringValue
                print("URL miniatury: \(String(describing: post.thumbnails.stringValue))")
                
            } catch let error as NSError {
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
        }
        
        do {
            try context.save()
            DispatchQueue.main.async {
                completion(nil)
            }
        } catch {
            DispatchQueue.main.async {
                completion(error)
            }
        }
    }
}

func saveCategoriesToCoreData(categories: [Category], completion: @escaping (Error?) -> Void) {
    let context = PersistenceController.shared.container.viewContext
    context.perform {
        for category in categories {
            let fetchRequest: NSFetchRequest<Categories> = Categories.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "idCategory == %@", NSNumber(value: category.id))
            
            do {
                let fetchedCategories = try context.fetch(fetchRequest)
                
                var newCategory: Categories!
                if let existingCategory = fetchedCategories.first {
                    newCategory = existingCategory
                } else {
                    newCategory = Categories(context: context)
                    newCategory.idCategory = Int16(category.id)
                }
                
                newCategory.name = category.name
                newCategory.slug = category.slug
            } catch let error as NSError {
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
        }
        
        do {
            try context.save()
            DispatchQueue.main.async {
                completion(nil)
            }
        } catch {
            DispatchQueue.main.async {
                completion(error)
            }
        }
    }
}



//import CoreData
//
//func savePostsToCoreData(posts: [WordpressPost], completion: @escaping (Error?) -> Void) {
//    let context = PersistenceController.shared.container.viewContext
//
//    for post in posts {
//        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "idPost == %@", NSNumber(value: post.id))
//
//        do {
//            let fetchedPosts = try context.fetch(fetchRequest)
//
//            var newPost: Post!
//            if let existingPost = fetchedPosts.first {
//                // Jeżeli post istnieje, to sprawdzamy czy powinien zostać zaktualizowany
//                let serverModifiedDate = customISO8601DateFormatter().date(from: post.modified)
//                if serverModifiedDate?.compare(existingPost.modified!) == .orderedDescending {
//                    // Jeżeli data modyfikacji na serwerze jest późniejsza, to aktualizujemy post
//                    newPost = existingPost
//                } else {
//                    // Jeżeli data modyfikacji na serwerze nie jest późniejsza, to nie aktualizujemy posta
//                    continue
//                }
//            } else {
//                // Jeżeli post nie istnieje, to go dodajemy
//                newPost = Post(context: context)
//                newPost.idPost = Int16(post.id)
//            }
//
//            newPost.date = customISO8601DateFormatter().date(from: post.date)
//            newPost.modified = customISO8601DateFormatter().date(from: post.modified)
//            newPost.slug = post.slug
//            newPost.status = post.status
//            newPost.type = post.type
//            newPost.link = post.link
//            newPost.title = post.title.rendered
//            newPost.content = post.content.rendered
//            newPost.excerpt = post.excerpt.rendered
//            newPost.categories = post.categories as NSArray? ?? []
//            newPost.tags = post.tags as NSArray? ?? []
//            newPost.thumbnails = post.thumbnails.stringValue
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//            DispatchQueue.main.async {
//                completion(error)
//            }
//            return
//        }
//    }
//
//    context.performAndWait {
//        do {
//            try context.save()
//            DispatchQueue.main.async {
//                completion(nil)
//            }
//        } catch {
//            print("Failed to save context:", error)
//            DispatchQueue.main.async {
//                completion(error)
//            }
//        }
//    }
//}
//
//
//
//private func fetchAndUpdatePosts(completion: @escaping (Error?) -> Void) {
//    // Na początku sprawdzamy, czy są już jakieś posty zapisane
//    let postQuery = PostQuery()
//    if postQuery.arePostsStoredInCoreData() {
//        // Jeżeli są, powinniśmy pobrać posty i zaktualizować je
//        // Tutaj musimy zdecydować, jak zidentyfikować nowe posty i jakie posty powinny być aktualizowane
//        // Na razie nie implementujemy tej części.
//    } else {
//        // Jeżeli nie ma żadnych postów, to pobieramy wszystkie
//        postQuery.fetchNewPostsAndSaveToCoreData { error in
//            if let error = error {
//                print("Failed to fetch and update posts:", error)
//                completion(error)
//            } else {
//                print("Posts updated successfully.")
//                completion(nil)
//            }
//        }
//    }
//}
//
//
//
//
//func saveCategoriesToCoreData(categories: [Category], completion: @escaping (Error?) -> Void) {
//    let context = PersistenceController.shared.container.viewContext
//
//    for category in categories {
//        let fetchRequest: NSFetchRequest<Categories> = Categories.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "idCategory == %@", NSNumber(value: category.id))
//
//        do {
//            let fetchedCategories = try context.fetch(fetchRequest)
//            if let existingCategory = fetchedCategories.first {
//                // The category already exists, update it
//                existingCategory.name = category.name
//                existingCategory.slug = category.slug
//            } else {
//                // The category does not exist, create a new one
//                let newCategory = Categories(context: context)
//                newCategory.idCategory = Int16(category.id)
//                newCategory.name = category.name
//                newCategory.slug = category.slug
//            }
//
//            try context.save()
//        } catch let error as NSError {
//            print("Could not save category. \(error), \(error.userInfo)")
//            completion(error) // Call the completion with error
//            return // If an error occurs, no need to proceed further
//        }
//    }
//    completion(nil) // Call the completion without error, indicating a successful save
//}




//func savePostsToCoreData(posts: [WordpressPost], completion: @escaping (Error?) -> Void) {
//    let context = PersistenceController.shared.container.viewContext
//
//    for post in posts {
//        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "idPost == %@", NSNumber(value: post.id))
//
//        do {
//            let fetchedPosts = try context.fetch(fetchRequest)
//
//            var newPost: Post!
//            if let existingPost = fetchedPosts.first {
//                newPost = existingPost
//            } else {
//                newPost = Post(context: context)
//                newPost.idPost = Int16(post.id)
//            }
//
//            newPost.date = customISO8601DateFormatter().date(from: post.date)
//            newPost.modified = customISO8601DateFormatter().date(from: post.modified)
//            newPost.slug = post.slug
//            newPost.status = post.status
//            newPost.type = post.type
//            newPost.link = post.link
//            newPost.title = post.title.rendered
//            newPost.content = post.content.rendered
//            newPost.excerpt = post.excerpt.rendered
//            newPost.categories = post.categories as NSArray? ?? []
//            newPost.tags = post.tags as NSArray? ?? []
//            newPost.thumbnails = post.thumbnails.stringValue
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//            DispatchQueue.main.async {
//                completion(error)
//            }
//            return
//        }
//    }
//
//    context.performAndWait {
//        do {
//            try context.save()
//            DispatchQueue.main.async {
//                completion(nil)
//            }
//        } catch {
//            print("Failed to save context:", error)
//            DispatchQueue.main.async {
//                completion(error)
//            }
//        }
//    }
//}
