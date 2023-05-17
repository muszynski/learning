//
//  WPPost.swift
//  FundacjaSantander
//
//  Created by Łukasz Muszyński on 24/04/2023.
//

import Foundation

public struct WPPost: Identifiable, Codable {
    public let id: Int
    public let title: WPPostTitle
    public let link: String
    public let date: String
    public let categories: [Int]

    public struct WPPostTitle: Codable {
        public let rendered: String
    }
}

public func getWPPosts(username: String, appPassword: String, page: Int, completion: @escaping ([WPPost]) -> Void)  {
    let baseURL = "https://yourwebsite.com/wp-json/wp/v2/posts?page=\(page)&per_page=20"
    
    guard let url = URL(string: baseURL) else { return }
    
    var request = URLRequest(url: url)
    let authString = "\(username):\(appPassword)"
    if let authData = authString.data(using: .utf8) {
        let authValue = "Basic \(authData.base64EncodedString())"
        request.addValue(authValue, forHTTPHeaderField: "Authorization")
    }
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let data = data {
            do {
                let fetchedPosts = try JSONDecoder().decode([WPPost].self, from: data)
                DispatchQueue.main.async {
                    completion(fetchedPosts)
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }.resume()
}


//func fetchPosts(token: String, page: Int, completion: @escaping ([WPPost]) -> Void) {
//    let baseURL = "https://fundacjasantander.stronazen.pl/wp-json/wp/v2/posts?page=\(page)&per_page=20"
//
//    guard let url = URL(string: baseURL) else { return }
//
//    var request = URLRequest(url: url)
//    request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//
//    URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                print("Error during fetching posts: \(error)")
//                return
//            }
//
//            if let httpResponse = response as? HTTPURLResponse {
//                print("Fetching posts status code: \(httpResponse.statusCode)")
//            }
//
//            if let data = data {
//                do {
//                    let fetchedPosts = try JSONDecoder().decode([WPPost].self, from: data)
//                    print("Fetched posts: \(fetchedPosts)")
//                    DispatchQueue.main.async {
//                        completion(fetchedPosts)
//                    }
//                } catch {
//                    print("Error decoding JSON: \(error)")
//                }
//            }
//        }.resume()
//    }
