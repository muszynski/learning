//
//  PomagajView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 17/05/2023.
//

import SwiftUI

struct PomagajView: View {
    var body: some View {
        ScrollView {
            VStack {
                DonationBannerForm()
                    .padding(.bottom, 40) // dodaj padding zamiast Spacer
                Blik()
                DonationForm()
                PaymentSymbol()
                ContactInfo()
            }
            .padding(.bottom) // dodatkowy padding na dole, jeśli potrzebujesz
        }
    }
}

struct PomagajView_Previews: PreviewProvider {
    static var previews: some View {
        PomagajView()
    }
}


