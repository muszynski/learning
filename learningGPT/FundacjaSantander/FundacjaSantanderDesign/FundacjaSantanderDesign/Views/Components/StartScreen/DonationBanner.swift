//
//  DonationBanner.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 17/05/2023.
//

import SwiftUI

struct DonationBanner: View {
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color("santanderRed"))
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 110)

            HStack {
                VStack(alignment: .leading) {
                    Text("Pomagaj z Fundacją")
                        .font(.custom("SantanderHeadline-Regular", size: 24))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .padding(.leading)
                    
                    HStack {
                        Text("Santander")
                            .font(.custom("SantanderHeadline-Regular", size: 24))
                            .foregroundColor(.white)
                            .lineLimit(1)
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    }
                    .padding(.leading)
                }
                
                Spacer()
            }

            Image("donationLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 165)
                .offset(x: 90) //odsuniecie loga od prawej
        }
        .frame(width: UIScreen.main.bounds.width * 0.9)
    }
}

struct DonationBanner_Previews: PreviewProvider {
    static var previews: some View {
        DonationBanner()
    }
}





