//
//  CategoriesService.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 22/05/2023.
//

import Foundation
import CoreData
import Combine

class CategoriesService : ObservableObject{
    
    @Published var currentStatus: Status = .idle
    var cancellables = Set<AnyCancellable>()
    func fetchAndSaveCategories() -> AnyPublisher<Void, Error> {
        fetchCategories()
            .flatMap { categories -> AnyPublisher<Void, Error> in
                Future { promise in
                    saveCategoriesToCoreData(categories: categories) { saveError in
                        if let saveError = saveError {
                            promise(.failure(saveError))
                        } else {
                            promise(.success(()))
                        }
                    }
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    
    func loadCategoriesFromCoreData() -> [Int16: String] {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Categories> = Categories.fetchRequest()
        
        do {
            let categories = try context.fetch(fetchRequest)
            var categoryMap = [Int16: String]()
            for category in categories {
                categoryMap[category.idCategory] = category.name
            }
            return categoryMap
        } catch let error as NSError {
            print("Could not fetch categories. \(error), \(error.userInfo)")
            return [:]
        }
    }
    func fetchCategories() -> Future<[Category], Error> {
        Future { promise in
            let url = URL(string: "https://fundacja.santander.pl/wp-json/wp/v2/categories?per_page=30")!
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    self.currentStatus = .serverError
                    promise(.failure(error))
                    return
                }

                guard let data = data else {
                    self.currentStatus = .incorrectData
                    promise(.failure(NetworkError.incorrectData))
                    return
                }

                let decoder = JSONDecoder()
                if let categories = try? decoder.decode([Category].self, from: data) {
                    self.currentStatus = .upToDate
                    promise(.success(categories))
                } else {
                    self.currentStatus = .incorrectData
                    promise(.failure(NetworkError.incorrectData))
                }
            }
            task.resume()
        }
    }
}
