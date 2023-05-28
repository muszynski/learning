//
//  GetCategoryName.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 19/05/2023.
//

import Foundation
import CoreData

func getCategoryName(id: Int16, from viewContext: NSManagedObjectContext) -> String? {
    let fetchRequest: NSFetchRequest<Categories> = Categories.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "idCategory == %@", NSNumber(value: id))

    do {
        let categories = try viewContext.fetch(fetchRequest)
        if let category = categories.first {
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
