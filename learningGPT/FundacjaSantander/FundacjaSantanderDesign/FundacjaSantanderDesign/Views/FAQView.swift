//
//  FAQView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 17/05/2023.
//

import SwiftUI

struct FAQView: View {
    var body: some View {
        
        VStack {
            Title(title: "FAQ")
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(0..<10) { _ in
                        ToggleView(
                            title: "Pytanie",
                            content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed finibus turpis sed tortor laoreet, sed pulvinar sem tristique. Curabitur ut ante ullamcorper, interdum sapien non, mollis turpis. Ut congue erat eu risus accumsan fermentum. Suspendisse gravida, justo ac ultricies egestas, dolor arcu accumsan sapien, a facilisis ligula massa a magna."
                        )
                        .padding(.bottom, 10)
                    }
                    ContactInfo()
                }
                .padding()
            }
        }
    }
}

struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        FAQView()
    }
}

