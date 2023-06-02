//
//  PaymentForms.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 02/06/2023.
//
import SwiftUI

struct DonationFormView: View {
    @State private var amount: String = ""
    @State private var selectedAmount: Int? = nil
    @State private var donationType = "Darowizna"
    @State private var customDonationGoal = ""

    @State private var name = ""
    @State private var phone = ""
    @State private var email = ""
    
    @State private var isPrivacyPolicyAccepted = false
    @State private var isDataProcessingAccepted = false
    
    @State private var showSafariView = false
    @State private var paymentUrl: URL? = nil

    
    var body: some View {
        VStack(alignment: .leading) {

            
            Section(header:
                Text("Kwota:")
                    .font(.custom("SantanderText-Light", size: 14))
                    .foregroundColor(Color("fontGray"))
                    .padding(.top)
            ) {
                TextField("Wprowadź kwotę", text: $amount)
                    .font(.custom("SantanderText-Normal", size: 14))
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8.0)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .hideKeyboardWhenNotInUse()
                    .onChange(of: amount) { newValue in
                        if let _ = Int(newValue) {
                            selectedAmount = nil
                        }
                    }


                HStack {
                    AmountButton(amount: 10, selectedAmount: $selectedAmount, textAmount: $amount)
                    Spacer()
                    AmountButton(amount: 20, selectedAmount: $selectedAmount, textAmount: $amount)
                    Spacer()
                    AmountButton(amount: 50, selectedAmount: $selectedAmount, textAmount: $amount)
                    Spacer()
                    AmountButton(amount: 100, selectedAmount: $selectedAmount, textAmount: $amount)
                }
            }


            Section {
                Text("Cel zbiórki:")
                .font(.custom("SantanderText-Light", size: 14))
                .foregroundColor(Color("fontGray"))
                Menu {
                    Button(action: {
                        donationType = "Darowizna"
                    }) {
                        Text("Darowizna")
                    }
                    Button(action: {
                        donationType = "Podaj cel zbiórki"
                    }) {
                        Text("Podaj cel zbiórki")
                    }
                } label: {
                    HStack {
                        Text(donationType)
                            .font(.custom("SantanderText-Normal", size: 14))
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "chevron.down")
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8.0)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }
                .font(.custom("SantanderText-Normal", size: 14))
                
                if donationType == "Podaj cel zbiórki" {
                    TextField("Wprowadź cel zbiórki", text: $customDonationGoal)
                        .font(.custom("SantanderText-Normal", size: 14))
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8.0)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .hideKeyboardWhenNotInUse()
                }
            }
            
            Section{
                Text("Dane kontaktowe:")
                    .font(.custom("SantanderText-Light", size: 14))
                    .foregroundColor(Color("fontGray"))
                TextField("Imię i nazwisko", text: $name)
                    .font(.custom("SantanderText-Normal", size: 14))
                    
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8.0)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .hideKeyboardWhenNotInUse()
                TextField("Telefon (opcjonalnie)", text: $phone)
                    .font(.custom("SantanderText-Normal", size: 14))
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8.0)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .hideKeyboardWhenNotInUse()
                TextField("Adres email", text: $email)
                    .keyboardType(.emailAddress)
                    .font(.custom("SantanderText-Normal", size: 14))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8.0)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .hideKeyboardWhenNotInUse()
            }

            Section{
                Text("Zgody:")
                    .font(.custom("SantanderText-Light", size: 14))
                    .foregroundColor(Color("fontGray"))
                Toggle("Oświadczam, że zapoznałam /zapoznałem się z obowiązującą polityką prywatności Fundacji Santander i akceptuję wszystkie jej postanowienia", isOn: $isPrivacyPolicyAccepted)
                    .font(.custom("SantanderText-Light", size: 12))
                    .lineSpacing(1.5)
                Toggle("Wyrażam zgodę na przetwarzanie moich danych osobowych przez Fundację Santander Bank Polska SA. im. Ignacego Jana Paderewskiego w związku z realizacją darowizny", isOn: $isDataProcessingAccepted)
                    .font(.custom("SantanderText-Light", size: 12))
                    .lineSpacing(1.5)
            }

            Section {
                Button(action: {
                    let donationGoal = donationType == "Podaj cel zbiórki" ? customDonationGoal : donationType
                    let generator = PaymentURLGenerator(
                        idSellers: idSellers,  // Wprowadź prawidłowy idSellers tutaj
                        amount: amount,
                        description: donationGoal,
                        crc: crc,  // Wprowadź prawidłowy crc tutaj
                        securityCode: securityCode,  // Wprowadź prawidłowy securityCode tutaj
                        name: name,
                        email: email,
                        phone: phone
                    )
                    if let url = URL(string: generator.url) {
                        UIApplication.shared.open(url)
                    }
                }) {
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
                .disabled(!(isPrivacyPolicyAccepted && isDataProcessingAccepted))
            }

//            .fullScreenCover(isPresented: $showSafariView) {
//                if let url = paymentUrl {
//                    SafariView(url: url)
//                }
//            }


        }
        .padding(.horizontal)
    }
}

struct AmountButton: View {
    var amount: Int
    @Binding var selectedAmount: Int?
    @Binding var textAmount: String
    @State private var isSelected: Bool = false

    var body: some View {
        Button("\(amount) PLN") {
            DispatchQueue.main.async {
                textAmount = String(amount)
                selectedAmount = amount
                isSelected = (selectedAmount == amount)
            }
        }
        .buttonStyle(SelectButtonStyle(isSelected: $isSelected))
        .onChange(of: selectedAmount) { newValue in
            isSelected = (newValue == amount)
        }
    }
}

struct SelectButtonStyle: ButtonStyle {
    @Binding var isSelected: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("SantanderText-Bold", size: 14))
            .padding(.horizontal, 22)
            .padding(.vertical, 10)
            .background(isSelected ? Color("santanderRed") : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(6)
    }
}



extension View {
    func hideKeyboardWhenNotInUse() -> some View {
        return self
            .onTapGesture {
                let keyWindow = UIApplication.shared.connectedScenes
                    .filter {$0.activationState == .foregroundActive}
                    .map {$0 as? UIWindowScene}
                    .compactMap {$0}
                    .first?.windows
                    .filter {$0.isKeyWindow}.first
                keyWindow?.endEditing(true)
            }
    }
}

struct DonationFormView_Previews: PreviewProvider {
    static var previews: some View {
        DonationFormView()
    }
}

