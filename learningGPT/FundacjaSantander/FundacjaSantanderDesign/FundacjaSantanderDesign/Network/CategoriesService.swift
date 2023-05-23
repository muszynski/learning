//
//  CategoriesService.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 22/05/2023.
//

import Foundation

class CategoriesService {
    
    private let wordpressApi = WordPressAPI()
    
    func fetchAndSaveCategories() {
        wordpressApi.fetchCategories { result in
            switch result {
            case .success(let categories):
                saveCategoriesToCoreData(categories: categories) { error in
                    if let error = error {
                        print("Failed to save categories:", error)
                    } else {
                        print("Categories saved successfully.")
                    }
                }
            case .failure(let error):
                print("Failed to fetch categories:", error)
            }
        }
    }
}
