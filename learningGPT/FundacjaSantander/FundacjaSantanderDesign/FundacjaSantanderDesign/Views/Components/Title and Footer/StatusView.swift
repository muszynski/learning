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
        StatusView(status: .loading)
    }
}

