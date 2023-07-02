//
//  ButtonLink.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 02/07/2023.
//

import SwiftUI
import SafariServices

struct ButtonLink: View {
    let buttonText : String
    var urlButton : URL?
    @State private var showSafari = false
    
    init(buttonText: String, urlButton: URL? = nil) {
        self.buttonText = buttonText
        self.urlButton = urlButton ?? URL(string: defaultLink)
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Button(action: {
                showSafari = true
            }) {
                Text(buttonText)
                    .font(
                        Font.custom("SantanderText-Bold", size: 17)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.11, green: 0.11, blue: 0.11).opacity(0.94))
            }
            .padding(.horizontal, 27)
            .padding(.vertical, 12)
            .background(.white)
            .cornerRadius(24)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .inset(by: 0.5)
                    .stroke(.black.opacity(0.25), lineWidth: 1)
            )
            .sheet(isPresented: $showSafari) {
                SafariView(url: urlButton!)
            }
        }
    }
}

struct ButtonLink_Previews: PreviewProvider {
    static var previews: some View {
        ButtonLink(buttonText: "Więcej", urlButton: URL(string: "https://www.google.com"))
    }
}

