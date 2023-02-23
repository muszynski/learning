//
//  ListView.swift
//  LearningPath
//
//  Created by Łukasz Muszyński on 23/02/2023.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        Text("List View")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.green)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
