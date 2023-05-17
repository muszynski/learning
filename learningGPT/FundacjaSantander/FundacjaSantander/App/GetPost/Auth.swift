//
//  Auth.swift
//  FundacjaSantander
//
//  Created by Łukasz Muszyński on 24/04/2023.
//

import Foundation

public struct AuthToken: Codable {
    let token: String
}

public func getAuthToken(completion: @escaping (String) -> Void) {
    
    let authURL = "https://fundacjasantander.stronazen.pl/wp-json/jwt-auth/v1/token"
    let username = "api_read_swift"
    let password = "Qf*g2E8LFXWjGl8N%mKQa0kd"
    
    guard let url = URL(string: authURL) else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = try? JSONEncoder().encode(["username": username, "password": password])
    
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error during authentication: \(error)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Authentication status code: \(httpResponse.statusCode)")
            }
            
            if let data = data {
                do {
                    let authToken = try JSONDecoder().decode(AuthToken.self, from: data)
                    DispatchQueue.main.async {
                        completion(authToken.token)
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
