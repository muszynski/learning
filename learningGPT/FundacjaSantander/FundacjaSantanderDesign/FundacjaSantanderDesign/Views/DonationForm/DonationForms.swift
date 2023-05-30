//
//  FormElements.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 29/05/2023.
//
import SwiftUI

struct DonationForms: View {
    @State private var isDonationSelected = true
    @State private var isCollectionSelected = false
    @State private var selectedAmount: String? = nil
    @State private var customCollectionName = ""
    @State private var customAmount = ""

    var body: some View {
        VStack {
            Text("Lub pomóż za pomocą płatności elektronicznych:")
                .font(.title3)
                .fontWeight(.bold)
                .padding()
            Text("Cel zbiórki")
                .padding(.bottom, -5)
                .font(.custom("SantanderText-Light", size: 14))
                .offset(x: 15)

            RoundedRadioView(isSelected: $isDonationSelected, labelText: "Darowizna", fieldType: .select, keyboardType: .default)
            RoundedRadioView(isSelected: $isCollectionSelected, labelText: "Zbiórka", fieldType: .select, keyboardType: .default)

            if isCollectionSelected {
                RoundedRadioView(isSelected: .constant(false), labelText: customCollectionName.isEmpty ? "Wpisz nazwę zbiórki" : customCollectionName, fieldType: .input, keyboardType: .default)
            }
            Text("Wybierz lub wpisz kwotę")
                .padding(.bottom, -5)
                .font(.custom("SantanderText-Light", size: 14))
                .offset(x: 15)
            HStack {
                
                RoundedRadioView(isSelected: .constant(selectedAmount == "20 PLN"), labelText: "20 PLN", fieldType: .select, keyboardType: .default)
                    .onTapGesture {
                        selectedAmount = (selectedAmount == "20 PLN") ? nil : "20 PLN"
                        customAmount = ""
                    }

                RoundedRadioView(isSelected: .constant(selectedAmount == "50 PLN"), labelText: "50 PLN", fieldType: .select, keyboardType: .default)
                    .onTapGesture {
                        selectedAmount = (selectedAmount == "50 PLN") ? nil : "50 PLN"
                        customAmount = ""
                    }
                
            }
            .frame(maxWidth: .infinity)

            HStack {
                RoundedRadioView(isSelected: .constant(selectedAmount == "100 PLN"), labelText: "100 PLN", fieldType: .select, keyboardType: .default)
                    .onTapGesture {
                        selectedAmount = (selectedAmount == "100 PLN") ? nil : "100 PLN"
                        customAmount = ""
                    }

                RoundedRadioView(isSelected: .constant(selectedAmount == "200 PLN"), labelText: "200 PLN", fieldType: .select, keyboardType: .default)
                    .onTapGesture {
                        selectedAmount = (selectedAmount == "200 PLN") ? nil : "200 PLN"
                        customAmount = ""
                    }
            }
            .frame(maxWidth: .infinity)

            RoundedRadioView(isSelected: .constant(false), labelText: customAmount.isEmpty ? "Kwota" : customAmount, fieldType: .input, keyboardType: .numberPad)
                .onChange(of: customAmount, perform: { value in
                    if !value.isEmpty {
                        selectedAmount = nil
                    }
                })

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
            .frame(maxWidth: 360)
            .frame(height: 46)
            .background(Color("santanderRed"))
            .cornerRadius(8)
        }
        .padding()
    }
}

struct DonationForms_Previews: PreviewProvider {
    static var previews: some View {
        DonationForms()
    }
}
