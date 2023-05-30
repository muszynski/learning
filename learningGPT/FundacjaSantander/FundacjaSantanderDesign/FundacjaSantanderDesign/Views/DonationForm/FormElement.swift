//
//  FormElement.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 29/05/2023.
//
import SwiftUI

struct RoundedRadioView: View {
    
    @Binding var isSelected: Bool
    @State private var userInput = ""
    var labelText: String
    var fieldType: FieldType
    var keyboardType: UIKeyboardType
    
    enum FieldType {
        case input, select
    }
    
    var body: some View {
        let isSelectField = fieldType == .input
        
        return RoundedRectangle(cornerRadius: 6)
            .stroke(Color("fontGray"), lineWidth: 1)
            .foregroundColor(.white)
            .frame(height: 48)
            .overlay(
                HStack(spacing: 8) {
                    if isSelectField {
                        TextField(userInput.isEmpty ? labelText : "", text: $userInput, onCommit: {
                            if keyboardType == .numberPad, let _ = Int(userInput) {
                                // userInput is a valid integer
                            } else if keyboardType == .numberPad {
                                // userInput is not a valid integer, reset userInput
                                userInput = ""
                            }
                        })
                            .keyboardType(keyboardType)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color("formText"))
                            .font(.system(size: 16))
                            .padding(.leading, 8)
                            .disableAutocorrection(true)
                    } else {
                        ZStack {
                            Circle()
                                .strokeBorder(Color("buttonGreen"), lineWidth: 2)
                                .frame(width: 24, height: 24)
                                .padding(.leading, 8)
                            
                            if isSelected {
                                Circle()
                                    .fill(Color("buttonGreen"))
                                    .frame(width: 12, height: 12)
                                    .padding(.leading, 8)
                            }
                        }
                        
                        Text(labelText)
                            .font(.system(size: 16))
                            .foregroundColor(Color("formText"))
                            .padding(.leading, 8)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 8)
            )
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            .onTapGesture {
                if !isSelectField {
                    isSelected.toggle()
                }
            }
    }
}
