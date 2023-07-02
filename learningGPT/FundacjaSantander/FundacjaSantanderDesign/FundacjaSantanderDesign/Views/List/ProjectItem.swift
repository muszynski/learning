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
    let link : String
    let datePublication : String
    let textProcessor = TextProcessor()
    
    var body: some View {
        
        ZStack{
            VStack {
                ZStack(alignment: .topTrailing) {
                    ImageHolder(imageData: imageData)
                        .frame(height: 250)
                    HStack {
                        Spacer()
                        Text(categoryName)
                            .font(.custom("SantanderText-Bold", size: 14))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 3)
                            .background(Color("yellow"))
                            .foregroundColor(Color("fontDark"))
                            .cornerRadius(4)
                            .textCase(.uppercase)
                            .offset(y: 3)
                        Spacer()
                    }
                    .padding(.trailing, 0)  // 24 punktów odstępu od prawej strony
                }

                
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
                        .background(Color("santanderRed").opacity(1))
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




struct ProjectItem_Previews: PreviewProvider {
    static var previews: some View {
        ProjectItem(
            imageData: UIImage(named: "welcome")?.pngData(),
            title: "Example Title",
            content: "This is some example content for the preview. It's only a few lines long, but it should be enough to give you an idea of how the text will look. This is some example content for the preview. It's only a few lines long, but it should be enough to give you an idea of how the text will look.", categoryName: "Jakaś kategoria 2, wiadomosć", link: "https://fundacja.santander.pl", datePublication: "03.03.2023"
        )
//        .previewLayout(.sizeThatFits)
    }
}




//        ZStack(alignment: .topTrailing) {
//            HStack {
//                ImageHolder(imageData: imageData)
//                    .frame(width: 77, height: 160)
//                    .clipped()
//                VStack(alignment: .leading) {
//                    Text(title)
//                        .bold()
//                        .font(.custom("SantanderText-Bold", size: 14))
//                        .padding(.bottom, 3.0)
//                        .lineSpacing(0)
//                        .foregroundColor(Color("fontGray"))
//                        .lineLimit(2)
//
//                    Text(content)
//                        .font(.custom("SantanderText-Normal", size: 12))
//                        .lineSpacing(4)
//                        .foregroundColor(Color("fontGray"))
//                        .truncationMode(.tail)
//                        .lineLimit(3)
//
//                }
//                .padding(.leading)
//
//                Spacer()
//
//                Image(systemName: "chevron.right")
//                    .padding(.trailing)
//                    .font(.system(size: 16))
//                    .foregroundColor(Color("santanderRed"))
//            }
//            .padding(0)
//            .frame(width: UIScreen.main.bounds.width * 0.9, height: 160)
//            .background(Color.white)
//            .border(Color("lightBlue"), width: 1)
//            .shadow(color: Color.black.opacity(0.12), radius: 8, x: 0, y: 5)
//
//
//            Text(categoryName)
//                .font(.custom("SantanderText-Bold", size: 14))
//                .padding(.horizontal, 10)
//                .padding(.vertical, 3)
//                .background(Color("yellow"))
//                .foregroundColor(Color("fontDark"))
//                .cornerRadius(4)
//                .padding(10)
//                .offset(y: -15)
//                .textCase(.uppercase)
//
//            Text(datePublication)
//                .font(.custom("SantanderText-Normal", size: 12))
//                .padding(.horizontal, 10)
//                .padding(.vertical, 3)
////                .background(Color("darkBlue"))
//                .foregroundColor(Color("fontDark"))
//                .cornerRadius(4)
//                .padding(10)
//                .offset(y: 120)
//        }
