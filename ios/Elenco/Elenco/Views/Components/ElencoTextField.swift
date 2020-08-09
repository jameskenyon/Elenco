//
//  ElencoTextField.swift
//  Elenco
//
//  Created by James Kenyon on 12/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

/*
 
 Any view conforming to ElencoTextFieldDisplayable will be able to display
 a text field in their view.
 
 */
protocol ElencoTextFieldDisplayable {
    func userDidReturnOnTextField()
    func userDidEditTextField(newValue: String)
}

/*
 
 The Elenco Text Field will be responsible for displaying a more dynamic
 text field in the app. This way we can use this text field throughout the app
 for all of the text fields that we need.
 
 */

struct ElencoTextField: UIViewRepresentable {
    
    class Coordinator: NSObject, UITextFieldDelegate {

        @Binding var text: String
        var textFieldView: ElencoTextFieldDisplayable
    
        var didBecomeFirstResponder = false

        init(text: Binding<String>, view: ElencoTextFieldDisplayable) {
            _text = text
            self.textFieldView = view
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            if let newText = textField.text {
                text = newText
                self.textFieldView.userDidEditTextField(newValue: newText)
            }
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            self.textFieldView.userDidReturnOnTextField()
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.textFieldView.userDidReturnOnTextField()
            return true
        }

    }

    @Binding var text: String
    
    var isFirstResponder: Bool = false
    var textFieldView: ElencoTextFieldDisplayable
    var font: UIFont?
    var color: UIColor? = UIColor(named: "Tungsten")
    var placeholder: String? = nil
    var keyBoardType: UIKeyboardType = .default
    
    func makeUIView(context: UIViewRepresentableContext<ElencoTextField>) -> UITextField {
        let textField = UITextField()
        textField.font = font
        textField.textColor = color
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        textField.keyboardType = keyBoardType
        return textField
    }

    func makeCoordinator() -> ElencoTextField.Coordinator {
        return Coordinator(text: $text, view: textFieldView)
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<ElencoTextField>) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}
