//
//  BigHeader.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 02/07/2023.
//

import SwiftUI

import SwiftUI

enum HeaderType {
    case news
    case project
    case donation
    case faq
    
    var color: Color {
        switch self {
        case .news:
            return Color("pastelPurple")
        case .project:
            return Color("pastelGreenDark")
        case .donation:
            return Color("pastelGreen")
        case .faq:
            return Color("pastelYellow")
        }
    }
    
    var imageName: String {
        switch self {
        case .news:
            return "pastelNews"
        case .project:
            return "pastelProject"
        case .donation:
            return "pastelDonation"
        case .faq:
            return "pastelFaq"
        }
    }
}

struct BigHeader: View {
    var headerType: HeaderType

    var body: some View {
        ZStack {
            Rectangle()
                .fill(headerType.color) // Fill the rectangle with the color
                .frame(width: UIScreen.main.bounds.width, height: 250) // Set width to be screen width
                .ignoresSafeArea()

            HStack {
                Spacer() // Push the image to the right
                Image(headerType.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                    .frame(height: 200)
            }
        }
    }
}


struct BigHeader_Previews: PreviewProvider {
    static var previews: some View {
        BigHeader(headerType: .faq)
    }
}
