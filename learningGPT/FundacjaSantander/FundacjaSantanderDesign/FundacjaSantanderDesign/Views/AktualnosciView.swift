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
                    BigHeader(headerType: .news)
                    NewsLists()
                }
            }
            .edgesIgnoringSafeArea(.top) // dodane, aby zignorować bezpieczne obszary dla ScrollView
            .navigationViewStyle(StackNavigationViewStyle()) // dodane, aby usunąć domyślne marginesy NavigationView
        }
        .background(Color("bgGray"))
    }
}


struct AktualnosciView_Previews: PreviewProvider {
    static var previews: some View {
        AktualnosciView()
    }
}
