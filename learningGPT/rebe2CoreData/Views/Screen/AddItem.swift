//
//  AddItem.swift
//  rebe2CoreData
//
//  Created by Łukasz Muszyński on 11/03/2023.
//

import SwiftUI

struct AddItem: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var date : Date = Date()
    @State private var descriptionString : String = "testowy opis"
    @State private var id : UUID = UUID()
    @State private var isTrue : Bool = true
    @State private var numberDouble : Double = 0
    @State private var numberInList : Int = 0
    
    @State private var isPresented = false
    @FocusState private var isTextFieldFocused: Bool
    
    @State private var showModal = false
    @State private var selectedNumber : Double = 0
    
    var body: some View {
        // przycisk dodawania daty modal
        VStack {
            VStack {
                HStack{
                    Text(convertDate(date: date))
                    Text("\(selectedNumber)")
                }
                Button(action: {
                    isPresented = true
                }){
                    Text("Wybierz datę")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color(red: 0.79, green: 0.02, blue: 0.30))
                        .cornerRadius(8)
                }
                .sheet(isPresented: $isPresented) {
                    DatePickerView(date: $date, isPresented: $isPresented)
                }
                // miejsce na dodanie tekstu
                TextField("Enter text here", text: $descriptionString)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8.0)
                // kod dla toogle
                Toggle(isOn: $isTrue) {
                    Text("Przycisk dla Toogle")
                }
                //pole dla liczby
                Button(action: {
                    showModal = true
                }){
                    Text("Wybierz numer")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color(red: 0.79, green: 0.02, blue: 0.30))
                        .cornerRadius(8)
                }
                .sheet(isPresented: $showModal, onDismiss: {
                    self.showModal = false
                    self.numberDouble = selectedNumber
                }) {
                    AddNumber(selectedNumber: $selectedNumber)
                }
                // dodajmy przycisk zapisywania do bazy danych
                Button("Zapisz do bazy danych") {
                    // utwórz wpis do bazy danych
                    
                   let newVariousData = VariousData(context:self.managedObjectContext)
                    newVariousData.id = id
                    newVariousData.date = date
                    newVariousData.descriptionString = descriptionString
                    newVariousData.isTrue = isTrue
                    newVariousData.numberDouble = numberDouble
                    do {
                        try self.managedObjectContext.save()
                    } catch {
                        print("Error saving new item: \(error)")
                    }

                }
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color(red: 0.79, green: 0.02, blue: 0.30))
                    .cornerRadius(8)
            }
        }
        .padding()
        //ukrywanie klawiatury po kliknięciu gdzieś poza pole wpisywania
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

struct AddItem_Previews: PreviewProvider {
    static var previews: some View {
        AddItem()
    }
}
