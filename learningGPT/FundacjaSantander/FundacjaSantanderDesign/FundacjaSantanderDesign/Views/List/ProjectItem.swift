//
//  PostItem.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 17/05/2023.
//

import SwiftUI
import CoreData

struct ProjectItem: View {
    @Environment(\.managedObjectContext) private var viewContext
    let imageData: Data?
    let title: String
    let content: String
    let categoryName : String

    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack {
                ImageHolder(imageData: imageData)
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


            Text(categoryName)
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


struct ProjectItem_Previews: PreviewProvider {
    static var previews: some View {
        ProjectItem(
            imageData: UIImage(named: "welcome")?.pngData(),
            title: "Example Title",
            content: "This is some example content for the preview. It's only a few lines long, but it should be enough to give you an idea of how the text will look.", categoryName: "Jakaś kategoria 2"
        )
        .previewLayout(.sizeThatFits)
    }
}

