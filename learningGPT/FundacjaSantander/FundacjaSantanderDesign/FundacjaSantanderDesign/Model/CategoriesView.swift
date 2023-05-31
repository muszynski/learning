//
//  CategoriesView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 31/05/2023.
//

import SwiftUI
import CoreData

struct CategoriesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Categories.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Categories.name, ascending: true)]) private var categories: FetchedResults<Categories>

    var body: some View {
        List {
            ForEach(categories, id: \.self) { category in
                HStack {
                    Text(category.name ?? "")
                    Spacer()
                    Text("\(countPostsInCategory(category.idCategory))")
                }
            }
        }
    }

    func countPostsInCategory(_ categoryID: Int16) -> Int {
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
        do {
            let posts = try viewContext.fetch(fetchRequest)
            let postsInCategory = posts.filter { post in
                (post.categories as? [NSNumber])?.contains(NSNumber(value: categoryID)) == true
            }
            return postsInCategory.count
        } catch {
            print("Failed to fetch posts:", error)
            return 0
        }
    }

}


struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
