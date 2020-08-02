//
//  EditRecipeView.swift
//  Elenco
//
//  Created by James Bernhardt on 02/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct EditRecipeView: View {
    
    var recipe: Recipe?
    @State var recipeName: String = ""
    @State var time: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                
                HStack {
                    RecipeEditField(fieldName: "Name", fieldText: self.$recipeName, size: geometry.size)
                    
                    Spacer()
                    
                    VStack {
                        Text("Image")
                            .font(.custom("HelveticaNeue-Regular", size: 15))
                        .foregroundColor(Color("Light-Gray"))
                        
                        ZStack {
                            if self.recipe == nil {
                                RoundedRectangle(cornerRadius: 35)
                                .foregroundColor(Color("Light-Gray"))
                                .frame(width: 70, height: 70)
                            } else {
                                Image(uiImage: #imageLiteral(resourceName: "editList"))
                                    .resizable()
                                    .scaledToFit()
                                    .clipped()
                                    .frame(width: 70, height: 70)
                                    .cornerRadius(35)
                            }
                            Image(uiImage: #imageLiteral(resourceName: "editList"))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                        
                    }
                }
                
                RecipeEditField(fieldName: "Time", fieldText: self.$time, size: geometry.size)
                
            }
            .padding(.horizontal, 30)
        }
    }
    
    
}

struct RecipeEditField: View, ElencoTextFieldDisplayable {
    
    var fieldName: String
    @Binding var fieldText: String
    var size: CGSize
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(fieldName)
                .font(.custom("HelveticaNeue-Regular", size: 15))
            .foregroundColor(Color("Light-Gray"))
            
            ElencoTextField(text: $fieldText, isFirstResponder: false, textFieldView: self, font: UIFont(name: "HelveticaNeue-Bold", size: 25), color: UIColor.white)
                .textFieldStyle(PlainTextFieldStyle())
                .foregroundColor(Color("Tungtsen"))
                
                .frame(width: size.width * 0.6, height: 50)
        }
    }
    
    // MARK: - Text Field Delegate Methods
    func userDidReturnOnTextField() {
        print("Return")
    }
    
    func userDidEditTextField(newValue: String) {
        print("Print Edit")
    }
}


struct EditRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeView()
    }
}
