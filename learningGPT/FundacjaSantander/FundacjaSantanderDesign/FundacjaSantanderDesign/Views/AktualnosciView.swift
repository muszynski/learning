//
//  AktualnosciView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 17/05/2023.
//

import SwiftUI
import CoreData

struct AktualnosciView: View {
    var body: some View {
        ScrollView {
            VStack{
                Title(title: "Aktualności")
                NewsLists()
//                PaginationButtons()
                ContactInfo()
            }
        }
    }
}

struct AktualnosciView_Previews: PreviewProvider {
    static var previews: some View {
        AktualnosciView()
    }
}
