//
//  AktualnosciView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 17/05/2023.
//

import SwiftUI

struct AktualnosciView: View {
    var body: some View {
        ScrollView {
            VStack{
                Title(title: "Aktualności")

                VStack {
                    ForEach(0..<5) { item in
                        NewsItem(imageName: "welcome", title: "News Title", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed finibus turpis sed tortor laoreet, sed pulvinar sem tristique. Curabitur ut ante ullamcorper, interdum sapien non, mollis turpis. Ut congue erat eu risus accumsan fermentum. Suspendisse gravida, justo ac ultricies egestas, dolor arcu accumsan sapien, a facilisis ligula massa a magna. ", category: "Category")
                            .padding(.bottom, 10)
                    }
                    PaginationButtons()
                }
                ContactInfo()
            }
        }
    }
}

struct AktualnosciView_Previews: PreviewProvider {
    static var previews: some View {
        AktualnosciView()
    }
}
