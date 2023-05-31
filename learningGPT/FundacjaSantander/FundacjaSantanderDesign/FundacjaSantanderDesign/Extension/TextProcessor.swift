//
//  TextProcessor.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 30/05/2023.
//

import Foundation
import SwiftSoup
import WebKit
import SwiftUI

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
    
    func cleanHTMLSwiftSoupTag(stringToClean: String) -> String {
        do {
            let document: Document = try SwiftSoup.parse(stringToClean)
            let whitelist = try Whitelist.basic() // Pozwól na 'b', 'i', 'u', 'em', 'strong', 'sup', 'sub', 'big', 'small'
            let cleanedText: String = try SwiftSoup.clean(document.outerHtml() , "", whitelist, OutputSettings().prettyPrint(pretty: true)) ?? "Błąd"
            return cleanedText // Zwróć oczyszczony tekst z dozwolonymi tagami
        } catch Exception.Error(let type, let message) {
            print("Type: \(type), Message: \(message)")
            return stringToClean
        } catch {
            print("error")
            return stringToClean
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


struct AsyncHTMLView: UIViewRepresentable {
    let htmlString: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.loadHTMLString(htmlString, baseURL: nil)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if uiView.isLoading {
            return
        }
        
        if let currentHTML = uiView.url?.absoluteString, currentHTML == htmlString {
            return
        }

        uiView.loadHTMLString(htmlString, baseURL: nil)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: AsyncHTMLView

        init(_ parent: AsyncHTMLView) {
            self.parent = parent
        }
    }
}


