//
//  DonationBanner.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 17/05/2023.
//

import SwiftUI

struct DonationBanner: View {
    var body: some View {
        ZStack {
            // Text in the top left
            VStack {
                HStack {
                    Text("Chcesz szybko pomóc?")
                        .font(Font.custom("SantanderText-Normal", size: 36))
                        .kerning(0.35)
                        .foregroundColor(Color(red: 0.15, green: 0.19, blue: 0.23))
                    Spacer()
                }
                Spacer()
            }
            .padding(.top, 20)
            .padding(.leading, 42)

            // Image in the bottom right
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image("darowizna")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            
            // Text in the middle, a bit above the bottom
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("Przekaż darowiznę")
                        .font(Font.custom("SantanderText-Bold", size: 17).weight(.bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.11, green: 0.11, blue: 0.11).opacity(0.94))
                        .padding(.horizontal, 27)
                        .padding(.vertical, 12)
                        .background(Color.white)
                        .cornerRadius(24)
                    Spacer()
                }
                Spacer().frame(height: 10)  // Put the text above the bottom by 10
            }
        }
        .frame(width: 355, height: 320)
        .background(Color(red: 0.87, green: 1, blue: 0.7))
        .cornerRadius(34)
    }
}


struct DonationBanner_Previews: PreviewProvider {
    static var previews: some View {
        DonationBanner()
    }
}





//        ZStack(alignment: .center) {
//            RoundedRectangle(cornerRadius: 12)
//                .fill(Color("santanderRed"))
//                .frame(width: UIScreen.main.bounds.width * 0.9, height: 110)
//
//            HStack {
//                VStack(alignment: .leading) {
//                    Text("Pomagaj z Fundacją")
//                        .font(.custom("SantanderHeadline-Regular", size: 24))
//                        .foregroundColor(.white)
//                        .lineLimit(1)
//                        .padding(.leading)
//
//                    HStack {
//                        Text("Santander")
//                            .font(.custom("SantanderHeadline-Regular", size: 24))
//                            .foregroundColor(.white)
//                            .lineLimit(1)
//
//                        Image(systemName: "chevron.right")
//                            .font(.system(size: 24))
//                            .foregroundColor(.white)
//                    }
//                    .padding(.leading)
//                }
//
//                Spacer()
//            }
//
//            Image("donationLogo")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(height: 165)
//                .offset(x: 90) //odsuniecie loga od prawej
//        }
//        .frame(width: UIScreen.main.bounds.width * 0.9)
