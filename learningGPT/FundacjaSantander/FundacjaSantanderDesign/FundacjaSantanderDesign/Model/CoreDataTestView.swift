//
//  CoreDataTestView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 26/05/2023.
//

import SwiftUI
import CoreData

struct CoreDataTestView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Post.date, ascending: false)],
        animation: .default)
    private var posts: FetchedResults<Post>

    var body: some View {
        ScrollView {
            VStack {
                Text("Posts")
                    .font(.largeTitle)
                LazyVStack {
                    ForEach(posts, id: \.self) { post in
                        HStack {
                            if let thumb = post.postToThumb {
                                if let imageData = thumb.imageData {
                                    ImageHolder(imageData: imageData)
                                        .frame(width: 100, height: 100)
                                } else {
                                    Text("ImageData is nil for post \(post.title ?? "") with idPost \(post.idPost)")
                                        .foregroundColor(.red)
                                }
                            } else {
                                Text("No thumbnail for post \(post.title ?? "") with idPost \(post.idPost)")
                                    .foregroundColor(.red)
                            }

                            VStack(alignment: .leading) {
                                Text(post.title ?? "No Title")
                                    .font(.headline)
                                if let categoryArray = post.categories as? [Int], let categoryId = categoryArray.first {
                                    Text("\(getCategoryNameFromId(categoryId))")
                                        .font(.subheadline)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }

    private func getCategoryNameFromId(_ id: Int) -> String {
        if let categoryName = getCategoryName(id: Int16(id), from: viewContext) {
            return categoryName
        } else {
            return "Category \(id)" // Default return if category name is not found
        }
    }

}





//struct CoreDataTestView_Previews: PreviewProvider {
//    static var previews: some View {
//        CoreDataTestView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}


//import SwiftUI
//import CoreData
//import UIKit
//
//struct CoreDataTestView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Post.date, ascending: false)],
//        animation: .default)
//    private var posts: FetchedResults<Post>
//
//    var body: some View {
//        ScrollView {
//            VStack {
//                Text("Posts")
//                    .font(.largeTitle)
//                LazyVStack {
//                    ForEach(posts, id: \.self) { post in
//                        HStack {
//                            if let imageData = getThumbImageData(for: post),
//                               let uiImage = UIImage(data: imageData) {
//                                Image(uiImage: uiImage)
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 100, height: 100)
//                            } else {
//                                Text("No image")
//                                    .foregroundColor(.red)
//                            }
//
//                            VStack(alignment: .leading) {
//                                Text(post.title ?? "No Title")
//                                    .font(.headline)
//                                if let categoryArray = post.categories as? [Int],
//                                   let categoryId = categoryArray.first {
//                                    Text("\(getCategoryNameFromId(categoryId))")
//                                        .font(.subheadline)
//                                }
//                                if let thumb = getThumb(for: post) {
//                                    if let postId = thumb.postId {
//                                        Text("Thumb Post ID: \(postId)")
//                                            .font(.subheadline)
//                                            .foregroundColor(.gray)
//                                    } else {
//                                        Text("No Thumb Post ID")
//                                            .font(.subheadline)
//                                            .foregroundColor(.gray)
//                                    }
//                                }
//                            }
//                        }
//                        .padding()
//                    }
//                }
//            }
//        }
//    }
//
//    private func getCategoryNameFromId(_ id: Int) -> String {
//        if let categoryName = getCategoryName(id: Int16(id), from: viewContext) {
//            return categoryName
//        } else {
//            return "Category \(id)" // Default return if category name is not found
//        }
//    }
//
//    private func getThumb(for post: Post) -> Thumb? {
//        guard let thumb = post.postToThumb else {
//            return nil
//        }
//        return thumb
//    }
//
//    private func getThumbImageData(for post: Post) -> Data? {
//        guard let thumb = post.postToThumb,
//              let imageData = thumb.imageData else {
//            return nil
//        }
//        return imageData
//    }
//}
