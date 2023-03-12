//
//  DatePicker.swift
//  rebe2CoreData
//
//  Created by Łukasz Muszyński on 11/03/2023.
//

import SwiftUI

struct DatePickerView: View {
    @Binding var date: Date
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            DatePicker("Wybierz datę", selection: $date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
            HStack {
                Spacer()
                Button("Anuluj") {
                    isPresented = false
                }
                Spacer()
                Button("OK") {
                    isPresented = false
                }
                Spacer()
            }
        }
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView(date: .constant(Date()), isPresented: .constant(true))
    }
}
