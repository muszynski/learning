//
//  WelcomeBanner.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 17/05/2023.
//

import SwiftUI

struct WelcomeBanner: View {
    var body: some View {
        ZStack {
            VStack {
                Image("welcome")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 180)
                    .clipped()
                

            }
            .frame(width: UIScreen.main.bounds.width * 0.9)
            .background(Color.white)
            
            VStack {

                
                VStack(alignment: .center) {
                    Image("logoFundacja")
                        .resizable()
                        .scaledToFit()
                        .padding(10)
                        .frame(height: 100)
                    Text("Myślimy o przyszłości naszego kraju i dlatego inwestujemy w młodych, ambitnych i odpowiedzialnych ludzi. Promujemy postawy społeczne, inspirujemy do działania, stwarzamy możliwości.")
                        .font(.custom("SantanderText-Bold", size: 14)) // Here is the custom font
                        .foregroundColor(Color("fontDark"))
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(10)
                .frame(width: UIScreen.main.bounds.width * 0.9 - 20)
                .background(Color.white.opacity(0.74))
                .border(Color(red: 0.9, green: 0.95, blue: 0.97), width: 1)
                .shadow(color: Color(red: 0.9, green: 0.95, blue: 0.97).opacity(1), radius: 10, x: 0, y: 4)
                .offset(y: 150) // Here is the offset
            }
        }
    }
}

struct WelcomeBanner_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeBanner()
    }
}





