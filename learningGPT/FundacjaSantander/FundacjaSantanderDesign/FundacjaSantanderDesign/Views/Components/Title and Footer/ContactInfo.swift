//
//  ContactInfo.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 18/05/2023.
//

import SwiftUI

struct ContactInfo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Pomoc i kontakt")
                .font(.custom("SantanderText-Bold", size: 24))
                .padding(.bottom, 5)
            
            InfoLine(imageName: "phone.fill", text: "22 586 89 99 – programy grantowe")
            InfoLine(imageName: "phone.fill", text: "22 634 55 92 – sprawy administracyjne, umowy darowizn")
            InfoLine(imageName: "phone.fill", text: "22 534 17 26 – stypendia")
            InfoLine(imageName: "phone.fill", text: "22 534 17 50 – wolontariat pracowniczy")
            InfoLine(imageName: "envelope.fill", text: "fundacja@santander.pl")
        }
        .padding()
        .frame(maxWidth: .infinity)
        .padding([.leading, .trailing], UIScreen.main.bounds.width * 0.05) // 5% padding on each side will make the width 90% of the screen width
    }
}


struct InfoLine: View {
    var imageName: String
    var text: String

    var body: some View {
        HStack {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 12, height: 12)
                .padding(10)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
            
            Text(text)
                .font(.custom("SantanderText-Normal", size: 14))
                .foregroundColor(Color("fontDark"))
                
        }
    }
}

struct ContactInfo_Previews: PreviewProvider {
    static var previews: some View {
        ContactInfo()
    }
}

