//
//  CoreDataTestView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 26/05/2023.
//

import SwiftUI
import CoreData
import SwiftUIX

struct ProjektyView: View {
    
    var body: some View {
        VStack {
            Title(title: "Projekty i programy")
            ProjectList()
        }
    }
    
    
    struct ProjektyView_Previews: PreviewProvider {
        static var previews: some View {
            ProjektyView()
        }
    }
}
