//
//  NewsItem.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 18/05/2023.
//

import SwiftUI

struct NewsItem: View {
    let imageData: Data?
    let title: String
    let content: String
    let datePublication: String
    let textProcessor = TextProcessor()
    var body: some View {
        ZStack {
            VStack {
                ImageHolder(imageData: imageData)
                    .frame(height: 250)
                    .clipped()

                VStack(alignment: .leading, spacing: 8) {
                    Text(textProcessor.cleanHTML(title))
                        .font(Font.custom("SantanderText-Bold", size: 22))
                        .multilineTextAlignment(.leading)
                        .kerning(0.35)
                        .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.27))
                        .lineSpacing(0)

                    Text(textProcessor.cleanHTML(content))
                        .font(Font.custom("SantanderText-Normal", size: 14))
                        .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.27))
                        .multilineTextAlignment(.leading)
                        .lineLimit(8)
                        .lineSpacing(3)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: 0.5)
                        .background(Color(red: 0.33, green: 0.33, blue: 0.35).opacity(0.65))
                    HStack {
                        VStack {
                            Text("Opublikowano:")
                                .font(Font.custom("SantanderText-Normal", size: 11))
                                .kerning(0.06)
                                .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.27))
                            Text(datePublication)
                                .font(Font.custom("SantanderText-Normal", size: 13))
                                .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.27))
                        }
                        Spacer()
                        Text("Więcej")
                            .font(
                                Font.custom("SantanderText-Normal", size: 17)
                                    .weight(.bold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.11, green: 0.11, blue: 0.11).opacity(0.94))
                            .padding(.horizontal, 27)
                            .padding(.vertical, 12)
                            .background(Color.white)
                            .cornerRadius(24)
                            .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .inset(by: 0.5)
                                    .stroke(Color.black.opacity(0.35), lineWidth: 1)
                            )
                    }
                }
                .padding(.horizontal, 24)
            }
            .frame(width: 355)
        }
        .frame(width: 355, height: 522)
        .background(Color.white)
        .cornerRadius(16)
    }
}





struct NewsItem_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NewsItem(imageData: Data(),
                     title: "uspendisse gravida, justo ac ultricies egestas",
                     content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed finibus turpis sed tortor laoreet, sed pulvinar sem tristique. Curabitur ut ante ullamcorper, interdum sapien non, mollis turpis. Ut congue erat eu risus accumsan fermentum. Suspendisse gravida, justo ac ultricies egestas, dolor arcu accumsan sapien, a facilisis ligula massa a magna.", datePublication: "22.22.2222")
            
        }
    }
}
