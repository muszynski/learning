//
//  StatusBar.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 19/05/2023.
//

import SwiftUI

enum Status {
    case noConnection
    case loading
    case upToDate
    case idle
    case serverUnavailable
    case serverError
    case timeout
    case incorrectData
}

struct StatusView: View {
    let status: Status
    
    @State private var isVisible = false
    
    var body: some View {
        if status == .idle {
            EmptyView()
        } else {
            HStack {
                switch status {
                case .noConnection:
                    Image(systemName: "exclamationmark.icloud.fill") // Zastąp odpowiednią ikoną
                        .foregroundColor(Color("santanderRed"))
                    Text("Brak połączenia z internetem")
                        .font(.custom("SantanderText-Normal", size: 12))
                case .loading:
                    Image(systemName: "icloud.and.arrow.down.fill") // Zastąp odpowiednią ikoną
                        .foregroundColor(Color("yellow"))
                    Text("Pobieranie danych z internetu")
                        .font(.custom("SantanderText-Normal", size: 12))
                case .upToDate:
                    Image(systemName: "checkmark.icloud.fill") // Zastąp odpowiednią ikoną
                        .foregroundColor(Color("green"))
                    Text("Wszystko jest aktualne")
                        .font(.custom("SantanderText-Normal", size: 12))
                case .idle:
                    EmptyView()
                case .serverUnavailable:
                    Image(systemName: "exclamationmark.triangle.fill") // Zastąp odpowiednią ikoną
                        .foregroundColor(Color("santanderRed"))
                    Text("Serwer jest niedostępny")
                        .font(.custom("SantanderText-Normal", size: 12))
                case .serverError:
                    Image(systemName: "exclamationmark.octagon.fill") // Zastąp odpowiednią ikoną
                        .foregroundColor(Color("santanderRed"))
                    Text("Wystąpił błąd serwera")
                        .font(.custom("SantanderText-Normal", size: 12))
                case .timeout:
                    Image(systemName: "hourglass") // Zastąp odpowiednią ikoną
                        .foregroundColor(Color("santanderRed"))
                    Text("Żądanie przekroczyło limit czasu")
                        .font(.custom("SantanderText-Normal", size: 12))
                case .incorrectData:
                    Image(systemName: "exclamationmark.square.fill") // Zastąp odpowiednią ikoną
                        .foregroundColor(Color("santanderRed"))
                    Text("Dane są niewłaściwe lub niekompletne")
                        .font(.custom("SantanderText-Normal", size: 12))
                }
            }
            .foregroundColor(.primary)
            .padding(7)
            .background(Color.secondary.opacity(0.1))
            .cornerRadius(8)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding([.leading, .trailing], 20)
            .opacity(isVisible ? 1 : 0)
            .onAppear {
                withAnimation(.easeOut(duration: 1)) {
                    isVisible = true
                }
            }
            .transition(.move(edge: .top))
        }
    }
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView(status: .incorrectData)
    }
}

