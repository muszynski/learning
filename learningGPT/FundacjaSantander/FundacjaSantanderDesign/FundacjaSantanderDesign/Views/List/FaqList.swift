//
//  FaqList.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 29/05/2023.
//

import SwiftUI
import CoreData

struct FaqList: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(
        entity: Faq.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Faq.faqDate, ascending: true)]
    ) var faqs: FetchedResults<Faq>
    
    var body: some View {
        List {
            ForEach(faqs) { faq in
                FaqItem(title: faq.faqTitle ?? "Tytuł", content: faq.faqContent ?? "Treść")
            }
        }
    }
}


struct FaqList_Previews: PreviewProvider {
    static var previews: some View {
        FaqList()
    }
}

