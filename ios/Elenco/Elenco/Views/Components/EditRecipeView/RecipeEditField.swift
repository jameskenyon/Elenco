//
//  RecipeEditField.swift
//  Elenco
//
//  Created by James Bernhardt on 03/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct RecipeEditField: View, ElencoTextFieldDisplayable {
    
    var fieldName: String
    var placeholder: String
    @Binding var fieldText: String
    var size: CGSize
    var keyboardType: UIKeyboardType
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(fieldName)
                .font(.custom("HelveticaNeue-Regular", size: 15))
            .foregroundColor(Color("Light-Gray"))
            
            ElencoTextField(text: $fieldText, isFirstResponder: false, textFieldView: self, font: UIFont(name: "HelveticaNeue-Bold", size: 25), color: #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1), placeholder: placeholder, keyBoardType: keyboardType)
                .textFieldStyle(PlainTextFieldStyle())
                .foregroundColor(Color("Tungtsen"))
                .accentColor(Color("Teal"))
                .frame(width: size.width * 0.6, height: 50)
        }
        .padding(.horizontal, 30)
    }
    
    // MARK: - Text Field Delegate Methods
    func userDidReturnOnTextField() {}
    
    func userDidEditTextField(newValue: String) {}
}
