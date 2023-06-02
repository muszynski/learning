//
//  PaymentsLinkTest.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 01/06/2023.
//

import SwiftUI

struct PaymentsLinkTest: View {
    
    let generator = PaymentURLGenerator(idSellers: idSellers, amount: "1000.56", description: "Zazielenię żółtą gałąź dla szczawików ><?()(***(%$%%^$%&^%$##$%", crc: "aplikacja", securityCode: securityCode, name: "Łukasz Muszyński", email: "muszynski@gmail.com")
    
    var body: some View {
        HStack {
            Text("Wygenerowany URL: \(generator.url)")
        }.onAppear {
            print("Wygenerowany URL: \(generator.url)")
        }
    }
}

struct PaymentsLinkTest_Previews: PreviewProvider {
    static var previews: some View {
        PaymentsLinkTest()
    }
}
