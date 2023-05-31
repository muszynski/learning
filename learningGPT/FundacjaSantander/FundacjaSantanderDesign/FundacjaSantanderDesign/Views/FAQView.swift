//
//  FAQView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 17/05/2023.
//

import SwiftUI
import CoreData

struct FAQView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(
        entity: Faq.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Faq.faqDate, ascending: true)]
    ) var faqs: FetchedResults<Faq>
    
    var body: some View {
        ScrollView {
            VStack {
                Title(title: "FAQ")
                VStack {
                    ForEach(faqs) { faq in
                        FaqItem(title: faq.faqTitle ?? "Tytuł", content: faq.faqContent ?? "Treść")
                    }
//                    TestTextView()
                   
                }
                .padding()
                ContactInfo()
//                CategoriesView()
//                TestTextView()
            }
        }
    }
}



struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        FAQView()
    }
}

