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
            Divider()
            
    
            HStack{

                Spacer()
                LinkImageView(imageName: "facebook", url: URL(string: "https://www.facebook.com/FundacjaSantander")!, frameWidth: 32, frameHeight: 32)
                Spacer()
                LinkImageView(imageName: "instagram", url: URL(string: "https://www.instagram.com/fundacjasantander/")!, frameWidth: 32, frameHeight: 32)
                Spacer()
                LinkImageView(imageName: "linkedin", url: URL(string: "https://www.linkedin.com/company/fundacja-santander-bank-polska/")!, frameWidth: 32, frameHeight: 32)
                Spacer()
                LinkImageView(imageName: "youtube", url: URL(string: "https://www.youtube.com/channel/UCsbxGV_ZsgXfR7E2DWpuy9g")!, frameWidth: 32, frameHeight: 32)
                Spacer()

            }
            
            
            Title(title: "Social Media i Kontakt")
            
            InfoLine(imageName: "phone", text: "22 586 89 99 – programy grantowe")
            InfoLine(imageName: "phone", text: "22 634 55 92 – sprawy administracyjne, umowy darowizn")
            InfoLine(imageName: "phone", text: "22 534 17 26 – stypendia")
            InfoLine(imageName: "phone", text: "22 534 17 50 – wolontariat pracowniczy")
            InfoLine(imageName: "email", text: "fundacja@santander.pl")
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
            Image(imageName)
                .resizable()
                .frame(width: 24, height: 24)
                .padding(7)
//                .background(Color("fontGray"))
//                .foregroundColor(.white)
//                .clipShape(Circle())
            
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

