//
//  ImageHolder.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 19/05/2023.
//
import SwiftUI

struct ImageHolder: View {
    @State private var isLoading: Bool = true
    var imageData: Data?
    
    var body: some View {
        Group {
            if let data = imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .onAppear {
                        isLoading = false
                    }
            } else if isLoading {
                // Replace this with your custom loader
                ProgressView()
            } else {
                // Replace this with your custom no image view
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .onAppear {
            isLoading = false
        }

    }
}

struct ImageHolder_Previews: PreviewProvider {
    static var previews: some View {
        ImageHolder()
    }
}