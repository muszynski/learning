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
    case serverError
    // Możesz dodać inne błędy związane z siecią
}
