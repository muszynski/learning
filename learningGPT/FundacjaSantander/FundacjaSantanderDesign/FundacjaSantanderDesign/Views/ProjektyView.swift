//
//  ProjektyView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 20/05/2023.
//

import SwiftUI

struct ProjektyView: View {
    
    var body: some View {
        
        VStack {
            Title(title: "Programy grantowe i projekty")
                .padding(.bottom, 20)
                            ProjectList()
                                .frame(height: 600)
                                .padding(.bottom, 20)
            //                ContactInfo()
        }
    }
}

struct ProjektyView_Previews: PreviewProvider {
    static var previews: some View {
        ProjektyView()
    }
}
