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

    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack {
                ZStack(alignment: .bottom) {
                    ImageHolder(imageData: imageData)
                        .frame(width: 91, height: 100)
                        .clipped()

                    Text(datePublication)
                        .padding(.horizontal)
                        .padding(.vertical, 2)
                        .frame(minWidth: 91) // narzucamy minimalną szerokość
                        .font(.custom("SantanderText-Normal", size: 10))
                        .foregroundColor(.white)
                        .background(Color("santanderRed").opacity(1))
                }

                VStack(alignment: .leading) {
                    Text(title)
                        .bold()
                        .font(.custom("SantanderText-Bold", size: 12))
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 0.5)
                        .lineSpacing(0)
                        .foregroundColor(Color("fontGray"))
                        .lineLimit(2)

                    Text(content)
                        .font(.custom("SantanderText-Normal", size: 10))
                        .multilineTextAlignment(.leading)
                        .lineSpacing(2)
                        .foregroundColor(Color("fontGray"))
                        .truncationMode(.tail)
                        .lineLimit(3)
                }
                .padding(.leading)

                Spacer()

                Image(systemName: "chevron.right")
                    .padding(.trailing)
                    .font(.system(size: 16))
                    .foregroundColor(Color("santanderRed"))
            }
            .padding(0)
            .frame(width: UIScreen.main.bounds.width * 0.9, height: 100)
            .background(Color.white)
            .border(Color("lightBlue"), width: 1)
            .shadow(color: Color.black.opacity(0.12), radius: 8, x: 0, y: 5)
        }
    }

}




struct NewsItem_Previews: PreviewProvider {
    static var previews: some View {
        NewsItem(imageData: Data(),
                 title: "uspendisse gravida, justo ac ultricies egestas",
                 content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed finibus turpis sed tortor laoreet, sed pulvinar sem tristique. Curabitur ut ante ullamcorper, interdum sapien non, mollis turpis. Ut congue erat eu risus accumsan fermentum. Suspendisse gravida, justo ac ultricies egestas, dolor arcu accumsan sapien, a facilisis ligula massa a magna.", datePublication: "22.22.2222")
    }
}




