//
//  PaymentSymbol.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 18/05/2023.
//

import SwiftUI

struct PaymentSymbol: View {
    
    
    var body: some View {
        VStack{
//            HStack {
//                PaymentSingleIcon(paymentIcon: "blikBialy", paymentName: "BLIK", paymentText: "Szybka płatność on-line")
//                PaymentSingleIcon(paymentIcon: "przelew", paymentName: "Przelew", paymentText: "On-line lub tradycyjny")
//            }
//            HStack {
//                PaymentSingleIcon(paymentIcon: "karta", paymentName: "Karta", paymentText: "Debetowa lub kredytowa")
//                PaymentSingleIcon(paymentIcon: "portfel", paymentName: "Portfele elektroniczne", paymentText: "Google Play, Paypall")
//            }
            HStack{
                Spacer()
                Text("Płatności zapewnia")
                    .font(.custom("SantanderText-Normal", size: 14))
                Image("tPayLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 64)
                Spacer()
            }
        }
    }
}


struct PaymentSingleIcon: View {
    
    var paymentIcon: String
    var paymentName: String
    var paymentText: String
    
    var body: some View {
        VStack(alignment: .center) {
            Image(paymentIcon)
                .resizable()
                .scaledToFit()
                .frame(height: 60)
            Text(paymentName)
                .font(.custom("SantanderHeadline-Regular", size: 24))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(paymentText)
                .font(.custom("SantanderHeadline-Regular", size: 14))
                .lineLimit(2)
                .minimumScaleFactor(0.5)
        }
        .padding()
        .frame(width: 180, height: 180)
        .border(Color("lightBlue"), width: 1)  // you can adjust the color as needed
        .background(Color("lightBlue"))
    }
}



struct PaymentSymbol_Previews: PreviewProvider {
    static var previews: some View {
        PaymentSymbol()
    }
}
