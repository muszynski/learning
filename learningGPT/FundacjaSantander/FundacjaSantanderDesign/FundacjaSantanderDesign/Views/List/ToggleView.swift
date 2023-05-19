//
//  ToggleView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 18/05/2023.
//

import SwiftUI

struct ToggleView: View {
    @State private var isExpanded = false
    @State private var showContent = false
    var title: String
    var content: String

    var body: some View {
        VStack(alignment: .leading) {
            // Button with title
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                    if isExpanded {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            showContent = true
                        }
                    } else {
                        showContent = false
                    }
                }
            }) {
                HStack {
                    Text(title)
                        .foregroundColor(Color("fontDark"))
                        .font(.custom("SantanderText-Normal", size: 12))
                    Spacer()
                    Image(systemName: isExpanded ? "minus" : "plus")
                }
                .padding()
                .background(Color("lightBlue"))
                .cornerRadius(8)
            }

            // Content text
            if showContent {
                Text(content)
                    .padding([.leading, .bottom, .trailing])
                    .transition(.move(edge: .top))
            }
        }
        .background(Color("lightBlue"))
        .cornerRadius(8)
        .animation(.default, value: isExpanded)
    }
}

struct ToggleView_Previews: PreviewProvider {
    static var previews: some View {
        ToggleView(title: "Title", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed finibus turpis sed tortor laoreet, sed pulvinar sem tristique. Curabitur ut ante ullamcorper, interdum sapien non, mollis turpis. Ut congue erat eu risus accumsan fermentum. Suspendisse gravida, justo ac ultricies egestas, dolor arcu accumsan sapien, a facilisis ligula massa a magna.")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}