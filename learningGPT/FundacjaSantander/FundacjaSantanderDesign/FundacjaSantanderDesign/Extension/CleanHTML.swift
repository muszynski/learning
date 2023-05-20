//
//  CleanHTML.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 19/05/2023.
//

import Foundation

func cleanHTML(_ html: String) -> String {
    let pattern = "<[^>]+>"
    guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
        return html
    }

    let range = NSRange(location: 0, length: html.count)
    let cleanText = regex.stringByReplacingMatches(in: html, options: [], range: range, withTemplate: "")
    return cleanText
}
