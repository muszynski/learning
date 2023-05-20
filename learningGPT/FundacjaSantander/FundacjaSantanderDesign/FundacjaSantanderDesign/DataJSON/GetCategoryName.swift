//
//  GetCategoryName.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 19/05/2023.
//

import Foundation
import CoreData

func getCategoryName(id: NSManagedObjectID, from viewContext: NSManagedObjectContext) -> String? {
    do {
        let object = try viewContext.existingObject(with: id)
        if let category = object as? Categories {
            return category.name
        }
    } catch {
        print("Failed to fetch Category: \(error)")
    }
    return nil
}

var categoryMap: [Int16: String] = [:]

func getCategoryNames(from categories: NSObject?) -> [String] {
    guard let categoryIds = categories as? [Int16] else { return [] }
    return categoryIds.compactMap { categoryId in
        categoryMap[categoryId]
    }
}
