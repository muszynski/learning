//
//  FetchAndSaveThumbnails.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 19/05/2023.
//

import Foundation
import CoreData
import SwiftUI

func fetchAndSaveThumbnail(thumbnails: String, context: NSManagedObjectContext, completion: @escaping (Data?, Error?) -> Void) {
    guard let url = URL(string: thumbnails) else {
        completion(nil, NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
        return
    }

    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            completion(nil, error)
            return
        }
        
        guard let data = data, let image = UIImage(data: data) else {
            completion(nil, NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to convert data to UIImage"]))
            return
        }

        let targetWidth: CGFloat = 300
        let aspectRatio = image.size.height / image.size.width
        let targetSize = CGSize(width: targetWidth, height: targetWidth * aspectRatio)

        UIGraphicsBeginImageContextWithOptions(targetSize, false, UIScreen.main.scale)
        image.draw(in: CGRect(origin: .zero, size: targetSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let resizedImageData = resizedImage?.jpegData(compressionQuality: 1.0) else {
            completion(nil, NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to compress resized image"]))
            return
        }

        completion(resizedImageData, nil)
    }.resume()
}
