//
//  DonationForm.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 18/05/2023.
//

import SwiftUI

struct DonationForm: View {
    @State private var collectionType = ""
    @State private var collectionGoal = ""
    @State private var donationAmount = ""
    @State private var selectedDonation = ""

    let donationOptions = ["10 PLN", "20 PLN", "50 PLN", "100 PLN"]

    var body: some View {
        VStack(alignment: .leading) {
            Picker(selection: $collectionType, label: Text("Wybierz rodzaj zbiórki").foregroundColor(.gray)) {
                ForEach(["Option 1", "Option 2", "Option 3"], id: \.self) {
                    Text($0).tag($0)
                }
            }
            .frame(height: 46)
            .frame(maxWidth: .infinity)
            .border(Color("lightBlue"), width: 1)
            .shadow(color: Color.black.opacity(0.12), radius: 8, x: 0, y: 5)
            
            TextField("Wpisz cel zbiórki", text: $collectionGoal)
                .frame(height: 46)
                .frame(maxWidth: .infinity)
                .border(Color("lightBlue"), width: 1)
                .shadow(color: Color.black.opacity(0.12), radius: 8, x: 0, y: 5)
            
            VStack {
                HStack {
                    ForEach(donationOptions[0..<2], id: \.self) { option in
                        Button(action: {
                            selectedDonation = option
                            donationAmount = "" // clear the donation amount when a button is selected
                        }) {
                            Text(option)
                                .frame(maxWidth: .infinity)
                                .frame(height: 46)
                                .background(selectedDonation == option ? Color.blue : Color("lightBlue"))
                                .cornerRadius(0)
                                .shadow(color: Color.black.opacity(0.12), radius: 8, x: 0, y: 5)
                                .foregroundColor(Color("fontDark"))
                        }
                    }
                }
                
                HStack {
                    ForEach(donationOptions[2..<4], id: \.self) { option in
                        Button(action: {
                            selectedDonation = option
                            donationAmount = "" // clear the donation amount when a button is selected
                        }) {
                            Text(option)
                                .frame(maxWidth: .infinity)
                                .frame(height: 46)
                                .background(selectedDonation == option ? Color.blue : Color("lightBlue"))
                                .cornerRadius(0)
                                .shadow(color: Color.black.opacity(0.12), radius: 8, x: 0, y: 5)
                                .foregroundColor(Color("fontDark"))
                        }
                    }
                }
            }

            
            TextField("Wpisz kwotę", text: $donationAmount)
                .onChange(of: donationAmount) { newValue in
                    if !newValue.isEmpty {
                        selectedDonation = "" // clear the selected button when a value is entered in the textfield
                    }
                }
                .frame(height: 46)
                .frame(maxWidth: .infinity)
                .border(Color("lightBlue"), width: 1)
                .shadow(color: Color.black.opacity(0.12), radius: 8, x: 0, y: 5)
            
            Button(action: {}) {
                HStack {
                    Image("pomagaj")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foregroundColor(.white)
                    Text("Pomagaj")
                        .font(.custom("SantanderText-Bold", size: 14))
                        .foregroundColor(.white)
                }
            }
            .background(Color("santanderRed"))
            .frame(maxWidth: .infinity)
            .frame(height: 46)
            .background(Color("santanderRed"))
            .cornerRadius(8)
        }
        .padding()
    }
}

struct DonationForm_Previews: PreviewProvider {
    static var previews: some View {
        DonationForm()
    }
}

