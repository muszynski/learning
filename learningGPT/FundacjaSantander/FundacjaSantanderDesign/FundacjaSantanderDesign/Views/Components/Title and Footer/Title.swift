//
//  Title.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 18/05/2023.
//

import SwiftUI

struct Title: View {
    
    @State var title = "Tytuł ekranu"
    
    var body: some View {
        VStack {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 300, height: 36.7347)
              .background(
                Image("headerfundacjaLogo")
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: 300, height: 36.73469543457031)
                  .clipped()
              )
            Text(title)
                .font(.custom("SantanderText-Regular", size: 14))
//                .multilineTextAlignment(.trailing)
                .padding(.trailing, 20.0)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding([.leading, .trailing], UIScreen.main.bounds.width * 0.05) // 5% padding on each side will make the width 90% of the screen width
    }
}

struct Title_Previews: PreviewProvider {
    static var previews: some View {
        Title()
    }
}

