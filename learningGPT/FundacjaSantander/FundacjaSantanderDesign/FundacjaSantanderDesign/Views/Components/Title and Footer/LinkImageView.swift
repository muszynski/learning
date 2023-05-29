//
//  LinkImageView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 29/05/2023.
//

import SwiftUI

struct LinkImageView: View {
    let imageName: String
    let url: URL
    let frameWidth: CGFloat
    let frameHeight: CGFloat
    
    @State private var showSafariView = false // State variable to control SafariView presentation
    
    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: frameWidth, height: frameHeight)
            .onTapGesture {
                showSafariView = true
            }
            .sheet(isPresented: $showSafariView) {
                SafariView(url: url)
            }
    }
}

struct LinkImageView_Previews: PreviewProvider {
    static var previews: some View {
        LinkImageView(imageName: "facebook", url: URL(string: "https://facebook.com")!, frameWidth: 32, frameHeight: 32)
    }
}
