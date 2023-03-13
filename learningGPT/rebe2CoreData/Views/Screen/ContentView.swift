//
//  ContentView.swift
//  rebe2CoreData
//
//  Created by Łukasz Muszyński on 08/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var newItem : String = ""
    @State private var newName : String = ""
    @State private var dateAdd : Date = Date()
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \DB.name, ascending: true)],
//           animation: .default)
    
    @FetchRequest(entity: DB.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \DB.dateAdd, ascending: false)]
        ) var items: FetchedResults<DB>
    
    // wskaz nazwe encji
//       private var items: FetchedResults<DB>
                  
                  
    var body: some View {
        
        
        
        VStack {
            HStack{
                TextField("Wpisz nazwę", text: $newItem)
                TextField("Wpisz nazwę", text: $newName)
            }
            Button(action: {
                let newItem = DB(context: self.managedObjectContext)
                newItem.name = self.newItem
                newItem.lastName = self.newName
                newItem.dateAdd = Date()
                do {
                    try self.managedObjectContext.save()
                } catch {
                    print("Error saving new item: \(error)")
                }
            }, label: {
                Text("Add Item")
            })
            
            
            List {
                ForEach(items, id: \.self) { item in
                    Text("\(item.name ?? "Unknown") \(item.lastName ?? "Unknown") \(convertDate(date: item.dateAdd ?? Date()))")
                }

            }

        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
