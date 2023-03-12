//
//  ListView.swift
//  rebe2CoreData
//
//  Created by Łukasz Muszyński on 12/03/2023.
//

import SwiftUI

struct ListView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: VariousData.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \VariousData.date, ascending: false)]
    ) var items: FetchedResults<VariousData>
    
    
    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                Card(date: Binding<Date>(
                    get: { item.date ?? Date() },
                    set: { item.date = $0 }
                ),
                     descriptionString: Binding<String>(
                        get: { item.descriptionString ?? "" },
                        set: { item.descriptionString = $0 }
                     ),
                     isTrue: Binding<Bool>(
                        get: { item.isTrue },
                        set: { item.isTrue = $0 }
                     )
                )
            }
        }
        
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

