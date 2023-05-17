//
//  PomagajView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 17/05/2023.
//

import SwiftUI

struct PomagajView: View {
    var body: some View {
        VStack{
            DonationBannerForm()
            Spacer()
                .frame(height: 40)
            Blik()
            Spacer()
        }
    }
}

struct PomagajView_Previews: PreviewProvider {
    static var previews: some View {
        PomagajView()
    }
}
