//
//  PomagajView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 17/05/2023.
//

import SwiftUI

struct PomagajView: View {
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack {
                    Spacer()
                        .frame(height: 125)// Spacer na górze, żeby zrobić miejsce dla DonationBannerForm
                    Blik()
                    DonationFormView()
                    PaymentSymbol()
                    // ContactInfo()
                }
                .padding(.bottom) // dodatkowy padding na dole, jeśli potrzebujesz
            }

            DonationBannerForm()
                .padding(.bottom, 30) // dodaj padding zamiast Spacer
                .shadow(color: .gray, radius: 5, x: 0, y: 5) // Dodaj cień
        }
    }
}




struct PomagajView_Previews: PreviewProvider {
    static var previews: some View {
        PomagajView()
    }
}


