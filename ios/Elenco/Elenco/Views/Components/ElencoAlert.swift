//
//  ElencoAlert.swift
//  Elenco
//
//  Created by James Bernhardt on 03/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct ElencoAlert: View, ElencoTextFieldDisplayable {
    
    var title: String
    var message: String
    var placeholder: String
    var onCompleteAction: (String?) -> ()
    @State var text: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("Background"))
                    .shadow(color: Color("Light-Gray"), radius: 10)
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.7)
                
                .overlay(
                    VStack(alignment: .center, spacing: 5) {
                        Text(self.title)
                            .font(.custom("HelveticaNeue-Bold", size: 30))
                            .padding(.top, 35)
                        
                        ElencoTextField(text: self.$text, isFirstResponder: true, textFieldView: self, placeholder: self.placeholder)
                            .foregroundColor(Color("Background"))
                            .frame(width: geometry.size.width * 0.6, height: 50)
                            .font(.custom("HelveticaNeue-Regular", size: 20))
                            .multilineTextAlignment(.center)
                            .padding(.top, 30)
                        
                        Rectangle()
                            .foregroundColor(Color("Teal"))
                            .frame(width: geometry.size.width * 0.6, height: 1)
                        
                        Spacer()
                        
                        AddButton {
                            self.onCompleteAction(self.text)
                        }
                        .padding(.bottom, 25)
                    }
                )
            }
        }
    }
    
    // MARK: - Text field delegate
    func userDidReturnOnTextField() {}
    
    func userDidEditTextField(newValue: String) {}
}

struct AddButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    var onCompleteAction: () -> ()

    var body: some View {
        Button(action: {
            withAnimation {
                self.onCompleteAction()
            }
         }, label: {
            Text("+")
                .font(.custom("HelveticaNeue-Bold", size: 50))
                .foregroundColor(Color.white)
                .padding(.bottom, 10)
        })
        .buttonStyle(OrangeCircleButtonStyle())
        .shadow(color: colorScheme == .dark ? .clear : Color("Light-Gray").opacity(0.4) , radius: 4)
    }
    
}

struct ElencoAlert_Previews: PreviewProvider {
    static var previews: some View {
        ElencoAlert(title: "Add Ingredient", message: "Add ingredients to recipe", placeholder: "Add") { _ in
            print("Complete")
        }
    }
}
