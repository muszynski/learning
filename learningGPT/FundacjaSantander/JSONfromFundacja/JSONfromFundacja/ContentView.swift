//
//  ContentView.swift
//  JSONfromFundacja
//
//  Created by Łukasz Muszyński on 16/05/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear(perform: getToken)  // Wywołaj funkcję getToken() po załadowaniu widoku
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

