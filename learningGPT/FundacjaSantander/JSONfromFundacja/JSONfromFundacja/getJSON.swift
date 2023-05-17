//
//  getJSON.swift
//  JSONfromFundacja
//
//  Created by Łukasz Muszyński on 16/05/2023.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getToken()
    }

    func getToken() {
        let url = URL(string: "https://dev.mediagfx.pl/wp-json/jwt-auth/v1/token")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters = [
            "username": "app_rest_api",
            "password": "%Q)Jx5^RU8BDMyoc)QH2IPC4"
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch let error {
            print("Błąd podczas tworzenia JSON: \(error.localizedDescription)")
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Błąd podczas wykonywania zapytania: \(error)")
                return
            }

            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch let error {
                    print("Błąd podczas parsowania odpowiedzi: \(error)")
                }
            }
        }

        task.resume()
    }
}
