//
//  CategoriesService.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 22/05/2023.
//

import Foundation

class CategoriesService {
    
    private let wordpressApi = WordPressAPI()

    // Nowa funkcja, która pobiera i zapisuje wszystkie kategorie
    func fetchAndSaveAllCategories(completion: @escaping (Error?) -> Void) {
        let categoriesURL = URL(string: "https://fundacja.santander.pl/wp-json/wp/v2/categories?per_page=100")!
        wordpressApi.fetchCategories(from: categoriesURL) { result in
            switch result {
            case .success(let (categories, _)): // Rozpakowujemy krotkę tutaj
                saveCategoriesToCoreData(categories: categories) { error in
                    if let error = error {
                        print("Failed to save categories:", error)
                        completion(error)
                    } else {
                        print("Categories saved successfully.")
                        completion(nil)
                    }
                }
            case .failure(let error):
                print("Failed to fetch categories:", error)
                completion(error)
            }
        }
    }
}

