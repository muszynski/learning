//
//  PostItem.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 17/05/2023.
//

import SwiftUI

struct PostItem: View {
    let imageName: String
    let title: String
    let content: String
    let category: String

    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 77, height: 160)
                    .clipped()

                VStack(alignment: .leading) {
                    Text(title)
                        .bold()
                        .font(.custom("SantanderText-Bold", size: 14))
                        .padding(.bottom, 5.0)
                        .lineSpacing(16)
                        .foregroundColor(Color("fontGray"))

                    Text(content)
                        .font(.custom("SantanderText-Normal", size: 12))
                        .lineSpacing(4)
                        .foregroundColor(Color("fontGray"))
                        .truncationMode(.tail)
                        .lineLimit(5)

                }
                .padding(.leading)

                Spacer()

                Image(systemName: "chevron.right")
                    .padding(.trailing)
                    .font(.system(size: 16))
                    .foregroundColor(Color("santanderRed"))
            }
            .padding(0)
            .frame(width: UIScreen.main.bounds.width * 0.9, height: 160)
            .background(Color.white)
            .border(Color("lightBlue"), width: 1)
            .shadow(color: Color.black.opacity(0.12), radius: 8, x: 0, y: 5)


            Text(category.uppercased())
                .font(.custom("SantanderText-Bold", size: 14))
                .padding(.horizontal, 10)
                .padding(.vertical, 3)
                .background(Color("yellow"))
                .foregroundColor(Color("fontDark"))
                .cornerRadius(4)
                .padding(10)
                .offset(y: -20)
        }
    }
}

struct PostItem_Previews: PreviewProvider {
    static var previews: some View {
        PostItem(imageName: "welcome", title: "News Title", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed finibus turpis sed tortor laoreet, sed pulvinar sem tristique. Curabitur ut ante ullamcorper, interdum sapien non, mollis turpis. Ut congue erat eu risus accumsan fermentum. Suspendisse gravida, justo ac ultricies egestas, dolor arcu accumsan sapien, a facilisis ligula massa a magna. ", category: "Category")
    }
}



