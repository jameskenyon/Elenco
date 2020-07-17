//
//  AddIngredientTextField.swift
//  Elenco
//
//  Created by James Kenyon on 12/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct AddIngredientTextField: UIViewRepresentable {
    
    class Coordinator: NSObject, UITextFieldDelegate {

        @Binding var text: String
        var addIngredientView: AddIngredientView
    
        var didBecomeFirstResponder = false

        init(text: Binding<String>, addIngredientView: AddIngredientView) {
            _text = text
            self.addIngredientView = addIngredientView
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            if let newText = textField.text {
                text = newText
            }
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            addIngredientView.userDidAddReturnOnTextField()
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            addIngredientView.userDidAddReturnOnTextField()
            return true
        }

    }

    @Binding var text: String
    
    var isFirstResponder: Bool = false
    var addIngredientView: AddIngredientView
    
    func makeUIView(context: UIViewRepresentableContext<AddIngredientTextField>) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        return textField
    }

    func makeCoordinator() -> AddIngredientTextField.Coordinator {
        return Coordinator(text: $text, addIngredientView: addIngredientView)
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<AddIngredientTextField>) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}
