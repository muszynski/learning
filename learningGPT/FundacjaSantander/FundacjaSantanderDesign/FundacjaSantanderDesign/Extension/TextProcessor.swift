//
//  TextProcessor.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 30/05/2023.
//

import Foundation
import SwiftSoup

class TextProcessor {
    init() {}

    func cleanHTMLSwiftSoup(stringToClean: String) -> String {
        do {
            let document: Document = try SwiftSoup.parse(stringToClean)
            let cleanText: String = try document.text()
            return cleanText // Zwróć oczyszczony tekst
        } catch Exception.Error(let type, let message) {
            print("Type: \(type), Message: \(message)")
            return cleanHTML(stringToClean)
        } catch {
            print("error")
            return cleanHTML(stringToClean)
        }
    }
    
    func cleanHTML(_ html: String) -> String {
        let pattern = "<[^>]+>"
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return html
        }

        let range = NSRange(location: 0, length: html.count)
        let cleanText = regex.stringByReplacingMatches(in: html, options: [], range: range, withTemplate: "")
        return cleanText
    }
}


