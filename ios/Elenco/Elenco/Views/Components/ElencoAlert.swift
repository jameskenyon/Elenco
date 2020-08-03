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
                            .padding(.top, 50)
                        
                        ElencoTextField(text: self.$text, isFirstResponder: true, textFieldView: self, placeholder: "Add")
                            .foregroundColor(Color("Background"))
                            .frame(width: geometry.size.width * 0.6, height: 50)
                            .font(.custom("HelveticaNeue-Regular", size: 20))
                            .multilineTextAlignment(.center)
                            .padding(.top)
                        
                        Rectangle()
                            .foregroundColor(Color("Teal"))
                            .frame(width: geometry.size.width * 0.6, height: 1)
                        
                        Spacer()
                        
                        Button(action: {
                            self.onCompleteAction(self.text)
                        }) {
                            Text("+")
                                .foregroundColor(Color.white)
                                .font(.custom("HelveticaNeue-Regular", size: 50))
                                .padding(.bottom, 5)
                        }
                        .buttonStyle(OrangeCircleButtonStyle())
                        .padding(.bottom)
                    }
                )
            }
        }
    }
    
    // MARK: - Text field delegate
    func userDidReturnOnTextField() {}
    
    func userDidEditTextField(newValue: String) {}
}

struct ElencoAlert_Previews: PreviewProvider {
    static var previews: some View {
        ElencoAlert(title: "Add Ingredient", message: "Add ingredients to recipe") { _ in
            print("Compet")
        }
    }
}
