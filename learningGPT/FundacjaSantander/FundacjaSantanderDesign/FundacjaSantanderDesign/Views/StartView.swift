//
//  StartView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 17/05/2023.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                StatusView(status: .idle)
                VStack{
                    WelcomeBanner()
                    Spacer()
                        .frame(height: 170)
                    DonationBanner()
                    ProjectList()
                        .padding(.bottom)
                    ContactInfo()
                }
            }
        }
    }
}


struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}


