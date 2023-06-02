//
//  Blik.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 17/05/2023.
//

import SwiftUI

struct Blik: View {
    var body: some View {
        VStack (alignment: .leading) {
            //TODO: wyrownaj do lewej
            Text("Bezpośrednio BLIKiem na nr.:")
                .padding(.bottom, -10)
                .font(.custom("SantanderText-Light", size: 14))
                .offset(x: 15)
            HStack {
                
                Spacer()
                Image("blik")
                    .resizable()
                    .frame(width: 58, height: 58)
                Spacer()
                
                Text("516 925 400")
                    .font(.custom("SantanderHeadline-Regular", size: 33))
                Spacer()
                Image("copy")
                    .resizable()
                    .frame(width: 22, height: 22)
                    .onTapGesture {
                        UIPasteboard.general.string = "516 925 400"
                    }
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width * 0.9, height: 92)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
        .padding()
        }
    }
}

struct Blik_Previews: PreviewProvider {
    static var previews: some View {
        Blik()
    }
}

