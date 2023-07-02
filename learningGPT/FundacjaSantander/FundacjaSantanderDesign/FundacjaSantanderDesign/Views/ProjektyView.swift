//
//  CoreDataTestView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 26/05/2023.
//

import SwiftUI
import CoreData

struct ProjektyView: View {
    var body: some View {
        NavigationView {
            VStack {
                BigHeader(headerType: .project)
                    
                ProjectList()
            }
        }
    }
}
    struct ProjektyView_Previews: PreviewProvider {
        static var previews: some View {
            ProjektyView()
        }
    }
