//
//  CoreDataThumbTestView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 28/05/2023.
//

import SwiftUI

struct CoreDataThumbTestView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Thumb.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Thumb.postId, ascending: true)]
    )
    private var thumbs: FetchedResults<Thumb>
    
    var body: some View {
        List {
            ForEach(thumbs, id: \.self) { thumb in
                VStack(alignment: .leading) {
                    Text("Id: \(thumb.postId)")
                    if let imageData = thumb.imageData, let uiImage = imageData.toImage() {
                        Image(uiImage: uiImage)
                    }
                }
                .padding()
            }

        }
    }
}

extension Data {
    func toImage() -> UIImage? {
        guard let uiImage = UIImage(data: self) else {
            print("Brak obrazu w Core Data")
            return nil
        }
        return uiImage
    }
}


struct CoreDataThumbTestView_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataThumbTestView()
    }
}
