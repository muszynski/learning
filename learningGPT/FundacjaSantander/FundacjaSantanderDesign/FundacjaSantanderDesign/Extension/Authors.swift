//
//  Authors.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 30/05/2023.
//

import Foundation

enum Author: Int {
    case Jola = 18
    case Lukasz = 19
    case Magda = 21
    case Admin = 17

    var name: String {
        switch self {
        case .Jola: return "Jola Deneka-Kapkowska"
        case .Lukasz: return "Łukasz Zembko"
        case .Magda: return "Magda Szewczyk"
        case .Admin: return "Fundacja Santander"
        }
    }

    init(rawValue: Int) {
        switch rawValue {
        case 18: self = .Jola
        case 19: self = .Lukasz
        case 21: self = .Magda
        case 17: self = .Admin
        default: self = .Admin  // Assign a default case
        }
    }
}

