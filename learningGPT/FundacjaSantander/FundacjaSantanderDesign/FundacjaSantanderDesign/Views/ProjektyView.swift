//
//  ProjektyView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 17/05/2023.
//

import SwiftUI
import CoreData

struct ProjektyView: View {
    @FetchRequest(
        entity: Post.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Post.date, ascending: false)],
        predicate: NSPredicate(format: "status == %@", "publish")
    ) var posts: FetchedResults<Post>
    
    @State private var categoryMap: [Int16: String] = [:]
    
    var body: some View {

            VStack{
                Title(title: "Programy grantowe i projekty")
                
                
                //
                
                List {
                    ForEach(posts, id: \.self) { post in
                        VStack(alignment: .leading) {
                            ProjectItem(
                                imageData: post.thumbnailsImage,
                                title: post.title ?? "Title",
                                content: post.content ?? "Content",
                                categoryName: getCategoryNames(from: post.categories)
                            )
                        }
                    }
                }

                .onAppear {
                    categoryMap = DataService().loadCategoriesFromCoreData()
                }
            }
            
            func getCategoryNames(from categories: NSArray?) -> [String] {
                guard let categoryIds = categories as? [Int16] else { return [] }
                return categoryIds.compactMap { categoryId in
                    categoryMap[categoryId]
                }
                
                //
            }
        }
    }


struct ProjektyView_Previews: PreviewProvider {
    static var previews: some View {
        ProjektyView()
    }
}





