//
//  AnimatedLogo.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 28/05/2023.
//

import SwiftUI

struct AnimatedLogo: View {
    var body: some View {
        AnimatedImageViewRepresentable()
            .frame(width: 128, height: 128)
    }
}

struct AnimatedImageViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> AnimatedImageView {
        let imageView = AnimatedImageView()
        imageView.setupImageView()
        return imageView
    }

    func updateUIView(_ uiView: AnimatedImageView, context: Context) {}
}

class AnimatedImageView: UIView {
    var imageView: UIImageView!

    func setupImageView() {
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])

        imageView.contentMode = .scaleAspectFit
        var images: [UIImage] = []

        for i in 0...239 {
            let imageName = String(format: "Loader_%05d", i)
            if let img = UIImage(named: imageName) {
                images.append(img)
            }
        }

        imageView.animationImages = images
        imageView.animationDuration = Double(images.count) / 60.0  // 60 FPS
        imageView.animationRepeatCount = 0 // Infinite
        imageView.startAnimating()
    }
}

struct AnimatedLogo_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedLogo()
    }
}





