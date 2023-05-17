//
//  DonationBannerForm.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 17/05/2023.
//

import SwiftUI

struct DonationBannerForm: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            VStack {
                Spacer()
                Text("Pomagaj z Fundacją\nSantander")
                    .font(.custom("SantanderHeadline-Regular", size: 25))
                    .foregroundColor(.white)
                    .padding(.leading, 20)
                    .offset(x: -80)
                Spacer()
            }

            Image("donationLogo")
                .frame(height: 165)
                .offset(x: 70, y: 30)
        }
        .frame(width: UIScreen.main.bounds.width, height: 110)
        .background(Color("santanderRed"))
    }
}

struct DonationBannerForm_Previews: PreviewProvider {
    static var previews: some View {
        DonationBannerForm()
    }
}




