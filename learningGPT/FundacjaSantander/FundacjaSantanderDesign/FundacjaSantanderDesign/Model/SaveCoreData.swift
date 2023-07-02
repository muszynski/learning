//
//  SaveCoreData.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 19/05/2023.
//
//


import CoreData

func savePostsToCoreData(posts: [WordpressPost], completion: @escaping (Error?) -> Void) {
    
    let textProcessor = TextProcessor()
    
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
                //MARK: dodano czyszczenie z html przed zapisem posta - zwrocic uwage na obciazenie
                newPost.title = textProcessor.cleanHTMLSwiftSoup(stringToClean: post.title.rendered)
                //MARK: tutaj przetwarzamy content dla postów
                newPost.content = textProcessor.cleanHTMLAndPreserveParagraphs(stringToClean: post.content.rendered)
                newPost.excerpt = post.excerpt.rendered
                newPost.author = Int16(post.author)
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

//funkcja zapisujaca projekty

func saveProjectToCoreData(projects: [WordpressPost], completion: @escaping (Error?) -> Void) {
    
    let textProcessor = TextProcessor()
    
    let context = PersistenceController.shared.container.viewContext
    context.perform {
        for project in projects {
            let fetchRequest: NSFetchRequest<Project> = Project.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "idProject == %@", NSNumber(value: project.id))
            
            do {
                let fetchedProjects = try context.fetch(fetchRequest)
                
                var newProject: Project!
                if let existingProject = fetchedProjects.first {
                    let serverModifiedDate = customISO8601DateFormatter().date(from: project.modified)
                    if serverModifiedDate?.compare(existingProject.modified!) == .orderedDescending {
                        newProject = existingProject
                    } else {
                        continue
                    }
                } else {
                    newProject = Project(context: context)
                    newProject.idProject = Int16(project.id)
                }
                
                newProject.date = customISO8601DateFormatter().date(from: project.date)
                newProject.modified = customISO8601DateFormatter().date(from: project.modified)
                newProject.slug = project.slug
                newProject.status = project.status
                newProject.type = project.type
                newProject.link = project.link
                newProject.title = textProcessor.cleanHTMLSwiftSoup(stringToClean: project.title.rendered)
                newProject.content = textProcessor.cleanHTMLAndPreserveParagraphs(stringToClean: project.content.rendered)
                newProject.excerpt = project.excerpt.rendered
                newProject.author = Int16(project.author)
                newProject.categories = project.categories as NSArray? ?? []
                newProject.tags = project.tags as NSArray? ?? []
                newProject.thumbnails = project.thumbnails.stringValue
                
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


//funkcja zapisujaca kategorie
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
// funkcja zapisjaca posty z FAQ

func saveFaqToCoreData(faq: [FaqPosts], completion: @escaping (Error?) -> Void) {
    let context = PersistenceController.shared.container.viewContext
    context.perform {
        for faqItem in faq {
            let fetchRequest: NSFetchRequest<Faq> = Faq.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "faqId == %@", NSNumber(value: faqItem.id))
            
            do {
                let fetchedFaqs = try context.fetch(fetchRequest)
                
                var newFaq: Faq!
                if let existingFaq = fetchedFaqs.first {
                    let serverModifiedDate = customISO8601DateFormatter().date(from: faqItem.modified)
                    if serverModifiedDate?.compare(existingFaq.faqModified!) == .orderedDescending {
                        newFaq = existingFaq
                    } else {
                        continue
                    }
                } else {
                    newFaq = Faq(context: context)
                    newFaq.faqId = Int16(faqItem.id)
                }
                
                newFaq.faqTitle = faqItem.title.rendered
                newFaq.faqContent = faqItem.content.rendered
                newFaq.faqDate = customISO8601DateFormatter().date(from: faqItem.date)
                newFaq.faqModified = customISO8601DateFormatter().date(from: faqItem.modified)
                
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



