//
//  AddNumber.swift
//  rebe2CoreData
//
//  Created by Łukasz Muszyński on 11/03/2023.
//

import SwiftUI

struct AddNumber: View {
    @State private var addDouble : Double = 23
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedNumber: Double
    
    var body: some View {
        VStack{
            Picker("Select number", selection: $addDouble) {
                ForEach(0..<101) { number in
                    Text("\(number)")
                }
            }
            .pickerStyle(WheelPickerStyle())
            .labelsHidden()
            HStack {
                Spacer()
                Button("Anuluj") {
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                Button("OK") {
                    selectedNumber = addDouble
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
            }
            .padding()
        }
        .onAppear {
            addDouble = selectedNumber
        }
    }
}

struct AddNumber_Previews: PreviewProvider {
    static var previews: some View {
        AddNumber(selectedNumber: .constant(43))
    }
}
