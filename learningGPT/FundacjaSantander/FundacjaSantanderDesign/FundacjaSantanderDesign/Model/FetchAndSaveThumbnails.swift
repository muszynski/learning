//
//  FetchAndSaveThumbnails.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 19/05/2023.
//

import Foundation
import CoreData
import SwiftUI

class ImageProcessor {
    

    func fetchAndSaveThumbnail(thumbnail: Thumbnail, postId: Int, context: NSManagedObjectContext, completion: @escaping (Error?) -> Void) {
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = context

        doesThumbnailExist(postId: postId, context: privateContext) { (exists, error) in
            if exists || error != nil {
                print("Thumbnail already exists or there was an error: \(String(describing: error))")
                completion(CoreDataError.fetchingError)
                return
            }

            switch thumbnail {
            case .string(let urlString):
                self.fetchImageData(from: urlString) { (data, error) in
                    guard let data = data else {
                        print("Error fetching image data: \(String(describing: error))")
                        completion(NetworkError.fetchingError)
                        return
                    }

                    let targetWidth: CGFloat = 100
                    guard let resizedImageData = self.resizeImageData(data, toWidth: targetWidth) else {
                        completion(NetworkError.incorrectData)
                        return
                    }

                    self.saveThumbnail(postId: postId, imageData: resizedImageData, context: privateContext) { error in
                        if let error = error {
                            completion(error)
                        } else {
                            self.saveChanges(context: privateContext) { error in
                                if let error = error {
                                    completion(error)
                                } else {
                                    self.saveChanges(context: context) { error in
                                        if let error = error {
                                            print("Failed to save main context:", error)
                                            completion(error)
                                        } else {
                                            print("Thumbnail saved successfully.")
                                            completion(nil)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            case .int, .none:
                // Możesz tutaj obsłużyć przypadki, gdy thumbnail jest intem lub brakuje
                // Na razie przekażemy błąd, że dane są niepoprawne
                completion(NetworkError.incorrectData)
            }
        }
    }
    
    
    func saveThumbnail(postId: Int, imageData: Data, context: NSManagedObjectContext, completion: @escaping (Error?) -> Void) {
        context.perform {
            let newThumbnail = Thumb(context: context)
            newThumbnail.postId = Int16(postId)
            newThumbnail.imageData = imageData
            
            // Fetch the Post entity that corresponds to this thumbnail
            let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "idPost == %@", NSNumber(value: postId))
            do {
                let fetchedPosts = try context.fetch(fetchRequest)
                if let post = fetchedPosts.first {
                    // Assign the thumbnail to the post
                    post.postToThumb = newThumbnail
                }
            } catch {
                print("Failed to fetch the corresponding post:", error)
            }
            
            do {
                try context.save()
                print("Thumbnail saved successfully.")
                completion(nil)
            } catch {
                print("Failed to save context:", error)
                completion(error)
            }
        }
    }
    
    
    
    
    func doesThumbnailExist(postId: Int, context: NSManagedObjectContext, completion: @escaping (Bool, Error?) -> Void) {
        let fetchRequest: NSFetchRequest<Thumb> = Thumb.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "postId == %@", NSNumber(value: postId))
        do {
            let fetchedThumbnails = try context.fetch(fetchRequest)
            completion(!fetchedThumbnails.isEmpty, nil)
        } catch {
            print("Failed to fetch existing thumbnail:", error)
            completion(false, CoreDataError.fetchingError)
        }
    }
    
    func fetchImageData(from urlStr: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlStr) else {
            completion(nil, NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error fetching image data: \(error)")
                completion(nil, error)
            } else if let data = data {
                print("Successfully fetched image data from URL.")
                completion(data, nil)
            }
        }.resume()
    }
    
    func resizeImageData(_ data: Data, toWidth targetWidth: CGFloat) -> Data? {
        guard let image = UIImage(data: data) else {
            return nil
        }
        
        let aspectRatio = image.size.height / image.size.width
        let targetSize = CGSize(width: targetWidth, height: targetWidth * aspectRatio)
        
        UIGraphicsBeginImageContextWithOptions(targetSize, false, UIScreen.main.scale)
        image.draw(in: CGRect(origin: .zero, size: targetSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage?.jpegData(compressionQuality: 1.0)
    }
    
    
    func saveChanges(context: NSManagedObjectContext, completion: @escaping (Error?) -> Void) {
        context.perform {
            do {
                try context.save()
                print("Changes saved successfully.")
                completion(nil)
            } catch {
                print("Failed to save context:", error)
                completion(error)
            }
        }
    }
    
    func fetchImageWithRetry(url: URL, retryCount: Int = 3) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 404:
                    print("Network Error: \(NetworkError.notFound.localizedDescription)")
                default:
                    // handle other status codes...
                    break
                }
            }
            
            if let error = error as NSError?, error.domain == NSURLErrorDomain && retryCount > 0 {
                print("Failed to fetch image, retrying in 1 second...")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.fetchImageWithRetry(url: url, retryCount: retryCount - 1)
                }
            } else if let data = data {
                // Process image data
                print("Image data fetched successfully")
            }
        }
        
        task.resume()
    }
}
