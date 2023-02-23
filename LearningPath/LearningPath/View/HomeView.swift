//
//  HomeView.swift
//  LearningPath
//
//  Created by Łukasz Muszyński on 23/02/2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Home View")
                .font(.largeTitle)
                .fontWeight(.bold)
            .foregroundColor(.red)
            Text("Home View 222")
                .font(.largeTitle)
                .fontWeight(.bold)
            .foregroundColor(.red)
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
