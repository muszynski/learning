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
    let thumbnails: String
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
