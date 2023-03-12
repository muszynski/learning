//
//  Card.swift
//  rebe2CoreData
//
//  Created by Łukasz Muszyński on 12/03/2023.
//

import SwiftUI

struct Card: View {
    
    @Binding var date : Date
    @Binding var descriptionString : String
    @Binding var isTrue : Bool
    
    var body: some View {
        VStack{
            Text("\(descriptionString)")
                .foregroundColor(Color("GhostWhite"))
                
            Text("\(dayFormatter(date: date ))")
            if isTrue == true{
                Image(systemName: "checkmark.circle.fill")
            } else{
                Image(systemName: "checkerboard.shield")
            }
            
        }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("Tangerine"))
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.3), radius: 5)
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(width: UIScreen.main.bounds.width * 0.66)
            
    }
}

struct Card_Previews: PreviewProvider {
    @State static var date = Date()
    @State static var descriptionString = "Testowy opis jakiś"
    @State static var isTrue = false
    
    static var previews: some View {
        Card(date: $date, descriptionString: $descriptionString, isTrue: $isTrue)
    }
}

