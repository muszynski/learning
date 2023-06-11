//
//  ProjektyView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 17/05/2023.
//

import SwiftUI
import CoreData

struct ProjectList: View {
    @Environment(\.managedObjectContext) private var viewContext
    let categoriesService = CategoriesService()
    
    @FetchRequest(
        entity: Post.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Post.date, ascending: false)],
        animation: .default)
    private var posts: FetchedResults<Post>

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(posts.filter { post in
                    if let categoryArray = post.categories as? [Int] {
                        return categoryArray.contains(where: { $0 == 5 || $0 == 6 })
                    }
                    return false
                }, id: \.self) { post in
                    if let categoryArray = post.categories as? [Int] {
                        let categoryNamesString = getCategoryNamesFromIds(categoryArray)
                        if let date = post.date {
                            let formattedDate = formattedDateDayMontYear(from: date)
                            let imageData = post.postToThumb?.imageData
                            let projectItem = ProjectItem(imageData: imageData,
                                                          title: post.title ?? "",
                                                          content: post.content ?? "",
                                                          categoryName: categoryNamesString,
                                                          link: post.link ?? "",
                                                          datePublication: formattedDate)
                            NavigationLink(destination: PostDetailView(post: post)) {
                                getProjectItemView(projectItem: projectItem)
                            }
                        }
                    }
                }
            }
        }
    }

    private func getProjectItemView(projectItem: ProjectItem) -> some View {
        projectItem
            .padding(.top)
    }

    private func getCategoryNamesFromIds(_ ids: [Int]) -> String {
        let categoryNames = ids.compactMap { categoriesService.getCategoryName(id: Int16($0), from: viewContext) }
        return categoryNames.joined(separator: ", ")
    }
}


struct ProjectList_Previews: PreviewProvider {
    static var previews: some View {
        ProjectList()
    }
}
