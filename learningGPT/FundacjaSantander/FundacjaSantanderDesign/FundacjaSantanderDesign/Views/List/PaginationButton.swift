//
//  PaginationButton.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 18/05/2023.
//

import SwiftUI

struct PaginationButtons: View {
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                print("Poprzedni button was tapped")
            }) {
                HStack {
                    Image(systemName: "arrow.left")
                        .renderingMode(.template)
                        .foregroundColor(Color("santanderRed"))
                    Text("Poprzedni")
                        .foregroundColor(Color("fontDark"))
                        .font(.custom("SantanderText-Normal", size: 16))
                }
                .frame(width: 130, height: 46)
                .background(Color.white)
                .border(Color(red: 0.87, green: 0.93, blue: 0.95))
            }
            Spacer()
            
            Button(action: {
                print("Następny button was tapped")
            }) {
                HStack {
                    Text("Następny")
                        .foregroundColor(Color("fontDark"))
                        .font(.custom("SantanderText-Normal", size: 16))
                    Image(systemName: "arrow.right")
                        .renderingMode(.template)
                        .foregroundColor(Color("santanderRed"))
                }
                .frame(width: 130, height: 46)
                .background(Color.white)
                .border(Color(red: 0.87, green: 0.93, blue: 0.95))
            }
            Spacer()
        }
    }
}

struct Pagination_Previews: PreviewProvider {
    static var previews: some View {
        PaginationButtons()
    }
}

