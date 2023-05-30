//
//  AktualnosciView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 17/05/2023.
//

import SwiftUI

struct AktualnosciView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Title(title: "Aktualności")
                    NewsLists()
                    ContactInfo()
                }
            }
        }
    }
}


struct AktualnosciView_Previews: PreviewProvider {
    static var previews: some View {
        AktualnosciView()
    }
}

