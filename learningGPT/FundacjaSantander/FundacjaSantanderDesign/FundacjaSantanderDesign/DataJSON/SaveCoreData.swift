//
//  SaveCoreData.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 19/05/2023.
//

import CoreData

func savePostsToCoreData(posts: [WordpressPost]) {
    let context = PersistenceController.shared.container.viewContext

    for post in posts {
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "idPost == %@", NSNumber(value: post.id))

        do {
            let fetchedPosts = try context.fetch(fetchRequest)

            var newPost: Post!
            // Jeśli post o danym ID już istnieje, aktualizujemy go.
            // Jeśli nie, tworzymy nowy.
            if let existingPost = fetchedPosts.first {
                newPost = existingPost
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
            newPost.tags = post.tags as NSArray? ?? []
            newPost.thumbnails = post.thumbnails

            // Fetch and save thumbnail
            if let thumbnailUrl = post.thumbnails {
                fetchAndSaveThumbnail(thumbnails: thumbnailUrl, context: context) { (thumbnailData, error) in
                    guard let thumbnailData = thumbnailData else {
                        print("Failed to fetch thumbnail:", error ?? "Unknown error")
                        return
                    }

                    newPost.thumbnailsImage = thumbnailData
                }
            }
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    context.performAndWait {
        do {
            try context.save()
        } catch {
            print("Failed to save context:", error)
        }
    }
}



func saveCategoriesToCoreData(categories: [Category]) {
    let context = PersistenceController.shared.container.viewContext

    for category in categories {
        let fetchRequest: NSFetchRequest<Categories> = Categories.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "idCategory == %@", NSNumber(value: category.id))

        do {
            let fetchedCategories = try context.fetch(fetchRequest)
            if let existingCategory = fetchedCategories.first {
                // The category already exists, update it
                existingCategory.name = category.name
                existingCategory.slug = category.slug
            } else {
                // The category does not exist, create a new one
                let newCategory = Categories(context: context)
//                newCategory.catId = UUID()
                newCategory.idCategory = Int16(category.id)
                newCategory.name = category.name
                newCategory.slug = category.slug
            }

            try context.save()
        } catch let error as NSError {
            print("Could not save category. \(error), \(error.userInfo)")
        }
    }
}


