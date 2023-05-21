//
//  wordpressJSONstruct.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 18/05/2023.
//

import Foundation
//struktury do pobierania postów
struct WordpressPost: Decodable{
    let id: Int
    let date: String
    let modified: String
    let slug: String
    let status: String
    let type: String
    let link: String
    let title: TitlePost
    let content: Content
    let excerpt: Excerpt
    let categories: [Int]
    let tags: [Int]
    let thumbnails: Thumbnail
}

struct TitlePost: Decodable {
    let rendered: String
}

struct Content: Decodable {
    let rendered: String
}

struct Excerpt: Decodable {
    let rendered: String
}
// struktura do pobierania nazw kategorii
struct Category: Decodable {
    let id: Int
    let name: String
    let slug: String
}

enum Thumbnail: Decodable {
    case string(String)
    case int(Int)
    case none
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(Int.self) {
            self = .string(String(x))  // Konwertuj wartość Int na String
            return
        }
        self = .none
    }
    
    var stringValue: String? {
        switch self {
        case .string(let value):
            return value
        default:
            return nil
        }
    }
}
// obsluga bledow z Wordpress-a
struct APIErrorResponse: Decodable {
    let code: String
    let message: String
    let data: ErrorResponseData
}

struct ErrorResponseData: Decodable {
    let status: Int
}
