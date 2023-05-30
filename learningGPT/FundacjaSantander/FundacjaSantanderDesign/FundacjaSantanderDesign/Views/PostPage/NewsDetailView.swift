//
//  NewsDetailView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 30/05/2023.
//

import SwiftUI
import CoreData

struct NewsDetailView: View {
    let post: Post
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let thumb = post.postToThumb, let imageData = thumb.imageData {
                    Image(uiImage: UIImage(data: imageData)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 360, height: 190)
                        .clipped()
                }
                
                Text(post.title ?? "Tytuł postu")
                    .font(.custom("SantanderText-Bold", size: 16))
                    .lineSpacing(3)
                    .foregroundColor(Color("fontGray"))
                    
                
                HStack {
                    let author = Author(rawValue: Int(post.author))
                    Text(author.name)
                        .font(.custom("SantanderText-Bold", size: 16))
                        .lineSpacing(3)
                        .foregroundColor(Color("fontGray"))
                    Spacer()
                    Text(formattedDateDayMontYear(from: post.date ?? Date())) // If date doesn't exist, use current date as default
                        .font(.custom("SantanderText-Bold", size: 16))
                        .lineSpacing(3)
                        .foregroundColor(Color("fontGray"))
                }
                .padding(.top)
                
                Text(post.content ?? "Lorem Ipsum")
                    .font(.custom("SantanderText-Normal", size: 14))
                    .lineSpacing(3)
                    .foregroundColor(Color("fontGray"))
                    .padding(.top)
            }
            .padding()
        }
        .onAppear {
            print("Author ID from CoreData: \(post.author)") // Print to console
        }
        .navigationTitle("Aktualności")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func formattedDateDayMontYear(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy" // Modify as needed
        return formatter.string(from: date)
    }
}

struct NewsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

        // Dummy Thumb
        let thumbMock = Thumb(context: context)
        thumbMock.imageData = UIImage(named: "welcome")!.pngData() // replace "exampleImage" with the name of an image asset

        // Dummy Post
        let postMock = Post(context: context)
        postMock.title = "Example Title"
        postMock.content = "Example content..."
        postMock.date = Date()
        postMock.postToThumb = thumbMock
        postMock.author = Int16(Author.Jola.rawValue)

        return NewsDetailView(post: postMock)
    }
}




