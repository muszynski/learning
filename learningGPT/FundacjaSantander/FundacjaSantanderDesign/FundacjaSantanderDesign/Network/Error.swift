//
//  NetworkError.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 22/05/2023.
//

import Foundation

enum NetworkError: Error {
    case fetchingError
    case decodingError
    case savingError
    case urlError
    case incorrectData
    case serverError(Int)
    case notFound
    // Możesz dodać inne błędy związane z siecią

    var localizedDescription: String {
        switch self {
        case .fetchingError:
            return "Błąd pobierania danych"
        case .decodingError:
            return "Błąd dekodowania danych"
        case .savingError:
            return "Błąd zapisu danych"
        case .urlError:
            return "Błąd tworzenia URL"
        case .incorrectData:
            return "Otrzymano niepoprawne dane"
        case .serverError(let code):
            return "Błąd serwera (kod: \(code))"
        case .notFound:
            return "Zasób nie został znaleziony"
        }
    }
}

enum CoreDataError: Error {
    case fetchingError
    case savingError
    case deletingError
    case noObjectFound
    // Możesz dodać inne błędy związane z Core Data

    var localizedDescription: String {
        switch self {
        case .fetchingError:
            return "Błąd pobierania danych z Core Data"
        case .savingError:
            return "Błąd zapisu do Core Data"
        case .deletingError:
            return "Błąd usuwania z Core Data"
        case .noObjectFound:
            return "Nie znaleziono oczekiwanego obiektu w Core Data"
        }
    }
}

// Przykład użycia:
func performNetworkOperation() {
    // Tutaj wykonujesz operację sieciową
    // ...
    // Jeżeli coś poszło nie tak, wyrzucasz błąd:
    let error = NetworkError.fetchingError
    print("Network Error: \(error.localizedDescription)")
}

