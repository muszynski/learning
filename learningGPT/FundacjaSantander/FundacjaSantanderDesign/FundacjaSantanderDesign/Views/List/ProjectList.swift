//
//  ProjektyView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 17/05/2023.
//

import SwiftUI
import CoreData
import SwiftUIX

struct ProjectList: View {
    @Environment(\.managedObjectContext) private var viewContext
    let categoriesService = CategoriesService()
    
    @FetchRequest(
        entity: Post.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Post.date, ascending: false)],
        animation: .default)
    private var posts: FetchedResults<Post>

    @State private var showSafariView = false // State variable to control SafariView presentation
    @State private var selectedLink: URL? = nil // State variable to hold selected link
    
    var body: some View {
           ScrollView {
               LazyVStack {
                   ForEach(posts.filter { post in
                       if let categoryArray = post.categories as? [Int] {
                           return categoryArray.contains(where: { $0 == 6 || $0 == 5 })
                       }
                       return false
                   }, id: \.self) { post in
                       if let thumb = post.postToThumb, let imageData = thumb.imageData, let categoryArray = post.categories as? [Int] {
                           let categoryNamesString = getCategoryNamesFromIds(categoryArray)
                           if let date = post.date {
                               let formattedDate = formattedDateDayMontYear(from: date)
                               let projectItem = ProjectItem(imageData: imageData,
                                                             title: post.title ?? "",
                                                             content: post.content ?? "",
                                                             categoryName: categoryNamesString,
                                                             link: post.link ?? "",
                                                             datePublication: formattedDate)
                               getProjectItemView(projectItem: projectItem, post: post)
                           }
                       }
                   }
               }
           }
       }

       private func getProjectItemView(projectItem: ProjectItem, post: Post) -> some View {
           projectItem
               .padding(.top)
               .onTapGesture {
                   selectedLink = URL(string: post.link ?? "")
                   showSafariView = true
               }
               .sheet(isPresented: $showSafariView) {
                   SafariView(url: selectedLink ?? URL(string: "https://fundacja.santander.pl")!) // Example URL as fallback
               }
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
