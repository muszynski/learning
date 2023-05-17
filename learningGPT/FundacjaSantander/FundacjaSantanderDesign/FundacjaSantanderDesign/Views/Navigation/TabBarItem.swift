//  ContentView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 17/05/2023.
//

import SwiftUI

struct TabBarItem: View {
    let icon: String
    let title: String
    let isSelected: Bool

    var body: some View {
        GeometryReader { geo in
            if isSelected {
                Rectangle()
                    .frame(height: 3)
                    .foregroundColor(.red)
            }
            VStack {
                Image(icon)
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width / 2, height: geo.size.height / 2)
                    .padding(.top)
                    .foregroundColor(isSelected ? .red : .black)
                Text(title)
                    .font(Font.custom(isSelected ? "SantanderText-Bold" : "SantanderText-Regular", size: 12))
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .foregroundColor(isSelected ? Color("santanderRed") : Color("fontDark"))
    }
}

struct TabBarItem_Previews: PreviewProvider {
    static var previews: some View {
        TabBarItem(icon: "projekty", title: "Projekty", isSelected: false)
    }
}

