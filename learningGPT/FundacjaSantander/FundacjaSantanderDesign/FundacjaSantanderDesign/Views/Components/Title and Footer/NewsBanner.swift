//
//  NewsBanner.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 02/07/2023.
//

import SwiftUI

struct NewsBanner: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 354, height: 80)
                .background(Color(red: 0.86, green: 0.79, blue: 0.96))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .inset(by: 0)
                        .stroke(.white, lineWidth: 0)
                )

            HStack {
                VStack {
                    Spacer()
                    Text("Aktualności")
                        .font(Font.custom("SantanderText-Normal", size: 24))
                        .foregroundColor(Color(red: 0.15, green: 0.19, blue: 0.23))
                    Spacer()
                }
                .frame(width: 131.86246, alignment: .leading)
                
                Rectangle()
                    .foregroundColor(.clear)
                    .background(
                        Image("aktualnosciBanner")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    )
                    .frame(width: 153, height: 122)
            }
        }
    }
}


struct NewsBanner_Previews: PreviewProvider {
    static var previews: some View {
        NewsBanner()
    }
}


