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
            
            Title(title: "Social Media i Kontakt")
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
            
            
           
            
            InfoLine(imageName: "phone", text: "22 586 89 99 – programy grantowe", width: 24, height: 24)
            InfoLine(imageName: "phone", text: "22 634 55 92 – sprawy administracyjne, umowy darowizn", width: 24, height: 24)
            InfoLine(imageName: "phone", text: "22 534 17 26 – stypendia", width: 24, height: 24)
            InfoLine(imageName: "phone", text: "22 534 17 50 – wolontariat pracowniczy", width: 24, height: 24)
            InfoLine(imageName: "email", text: "fundacja@santander.pl", width: 24, height: 17)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .padding([.leading, .trailing], UIScreen.main.bounds.width * 0.05) // 5% padding on each side will make the width 90% of the screen width
    }
}


struct InfoLine: View {
    var imageName: String
    var text: String
    var width : CGFloat
    var height : CGFloat

    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: width, height: height)
                .padding(7)
            
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

