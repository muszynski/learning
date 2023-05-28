//
//  CoreDataTestCategoryView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 28/05/2023.
//

import SwiftUI
import CoreData

struct CoreDataTestCategoryView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Categories.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Categories.name, ascending: true)]
    )
    private var categories: FetchedResults<Categories>

    var body: some View {
        List {
            ForEach(categories, id: \.self) { category in
                VStack(alignment: .leading) {
                    Text("Id: \(category.idCategory)")
                    Text("Name: \(category.name ?? "No Name")")
                    Text("Slug: \(category.slug ?? "No Slug")")
                }
                .padding()
            }
        }
        .navigationTitle("Categories")
    }
}

struct CoreDataTestCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataTestCategoryView()
    }
}
