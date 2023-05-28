//
//  WordpressApi.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 23/05/2023.
//

import Foundation

class WordPressAPI : ObservableObject {
    
    @Published var posts: [WordpressPost] = []
    
    private var baseURL = defaultLink + "/wp-json/wp/v2"

    func fetchPosts(pageNumber: Int, completion: @escaping (Result<([WordpressPost], URLResponse?), NetworkError>) -> Void) {
        let url = URL(string: "\(baseURL)/posts?&per_page=\(postPerPage)&page=\(pageNumber)")!
        fetchData(from: url, completion: completion)
    }

    func fetchCategories(from url: URL, completion: @escaping (Result<([Category], URLResponse?), NetworkError>) -> Void) {
        fetchData(from: url, completion: completion)
    }

    private func fetchData<T: Decodable>(from url: URL, completion: @escaping (Result<(T, URLResponse?), NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.serverError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.incorrectData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success((decodedData, response)))
            } catch {
                completion(.failure(.incorrectData))
            }
        }
        task.resume()
    }
}



