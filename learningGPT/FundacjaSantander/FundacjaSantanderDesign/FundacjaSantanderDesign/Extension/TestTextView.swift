//
//  TestTextView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 30/05/2023.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        let cssString = """
            body {
                font-family: '-apple-system';
                font-size: 14px;
                color: #ec0000;
                overflow: hidden;
            }
            """
        let jsString = "var style = document.createElement('style'); style.innerHTML = '\(cssString)'; document.head.appendChild(style);"
        let userScript = WKUserScript(source: jsString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)

        let contentController = WKUserContentController()
        contentController.addUserScript(userScript)

        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController

        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.scrollView.isScrollEnabled = false // disable scroll
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(htmlContent: "<body><strong>Witaj, świecie!</strong><p>To jest przykładowy tekst w formacie HTML.</p></body>")
    }
}















//
//import SwiftUI
//import MarkdownUI
//
//struct HTMLTextView: View {
//    let markdownString: String
//
//    var body: some View {
//        VStack {
//            Text("Markdown in Action")
//
//            Markdown(markdownString)
//                .font(.custom("SantanderText-Normal", size: 10))
//
//        }
//    }
//}
//
//struct TestTextView: View {
//    let testMarkdown = """
//    **To jest pierwsze zdanie z pogrubieniem.**
//
//    To jest drugie zdanie bez formatowania.
//
//    - **To jest trzecie zdanie, element listy z pogrubieniem.**
//    - To jest czwarte zdanie, element listy bez formatowania.
//
//    **To jest piąte zdanie z pogrubieniem.**
//
//    - **To jest szóste zdanie, element listy z pogrubieniem.**
//    - To jest siódme zdanie, element listy bez formatowania.
//
//    To jest ósme zdanie bez formatowania.
//
//    - **To jest dziewiąte zdanie, element listy z pogrubieniem.**
//    - To jest dziesiąte zdanie, element listy bez formatowania.
//    """
//
//    var body: some View {
//        HTMLTextView(markdownString: testMarkdown)
//    }
//}
//
//struct TestTextView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestTextView()
//    }
//}
//





