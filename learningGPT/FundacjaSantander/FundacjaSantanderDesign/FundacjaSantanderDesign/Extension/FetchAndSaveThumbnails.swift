//
//  FetchAndSaveThumbnails.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 19/05/2023.
//

import Foundation
import CoreData
import SwiftUI

func fetchAndSaveThumbnail(thumbnails: String, postId: Int, context: NSManagedObjectContext, completion: @escaping (Error?) -> Void) {
    doesThumbnailExist(postId: postId, context: context) { (exists, error) in
        if exists || error != nil {
            completion(error)
            return
        }
        
        fetchImageData(from: thumbnails) { (data, error) in
            guard let data = data else {
                completion(error)
                return
            }
            
            let targetWidth: CGFloat = 100
            guard let resizedImageData = resizeImageData(data, toWidth: targetWidth) else {
                completion(NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to resize and compress image"]))
                return
            }
            
            saveThumbnail(postId: postId, imageData: resizedImageData, context: context, completion: completion)
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
        completion(false, error)
    }
}

func fetchImageData(from urlStr: String, completion: @escaping (Data?, Error?) -> Void) {
    guard let url = URL(string: urlStr) else {
        completion(nil, NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
        return
    }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        completion(data, error)
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

func saveThumbnail(postId: Int, imageData: Data, context: NSManagedObjectContext, completion: @escaping (Error?) -> Void) {
    let newThumbnail = Thumb(context: context)
    newThumbnail.idPost = Int16(postId)
    newThumbnail.imageData = imageData

    context.performAndWait {
        do {
            try context.save()
            completion(nil)
        } catch {
            print("Failed to save context:", error)
            completion(error)
        }
    }
}


//func fetchAndSaveThumbnail(thumbnails: String, context: NSManagedObjectContext, completion: @escaping (Data?, Error?) -> Void) {
//    guard let url = URL(string: thumbnails) else {
//        completion(nil, NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
//        return
//    }
//
//    URLSession.shared.dataTask(with: url) { (data, response, error) in
//        if let error = error {
//            completion(nil, error)
//            return
//        }
//
//        guard let data = data, let image = UIImage(data: data) else {
//            completion(nil, NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to convert data to UIImage"]))
//            return
//        }
//
//        let targetWidth: CGFloat = 100
//        let aspectRatio = image.size.height / image.size.width
//        let targetSize = CGSize(width: targetWidth, height: targetWidth * aspectRatio)
//
//        UIGraphicsBeginImageContextWithOptions(targetSize, false, UIScreen.main.scale)
//        image.draw(in: CGRect(origin: .zero, size: targetSize))
//        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        guard let resizedImageData = resizedImage?.jpegData(compressionQuality: 1.0) else {
//            completion(nil, NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to compress resized image"]))
//            return
//        }
//
//        completion(resizedImageData, nil)
//    }.resume()
//}
