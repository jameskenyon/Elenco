//
//  EditRecipeView.swift
//  Elenco
//
//  Created by James Bernhardt on 02/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct EditRecipeView: View {
    
    var recipe: Recipe
    @State var recipeName: String = ""
    @State var time: String = ""
    @State var isVegitarian: Bool = false
    @State var isNutFree: Bool = false
    @State var isGlutenFree: Bool = false
    var ingredients: Ingredients
    var method: Instructions
    
    init(editRecipe recipe: Recipe) {
        UISwitch.appearance().onTintColor = #colorLiteral(red: 0.3696106672, green: 0.7883469462, blue: 0.6629261374, alpha: 1)
        self.recipe = recipe
        self.ingredients = recipe.ingredients
        self.method = recipe.method
//        recipeName = recipe.name
//        time = recipe.estimatedTime
        print(recipe.dietaryRequirements ?? "No requirements")
    }
    
    init() {
        UISwitch.appearance().onTintColor = #colorLiteral(red: 0.3696106672, green: 0.7883469462, blue: 0.6629261374, alpha: 1)
        self.ingredients = Ingredients()
        self.method = Instructions()
        self.recipe = Recipe(name: "recipeName", recipeID: UUID(), serves: 0, estimatedTime: "time", ingredients: ingredients, method: method)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                
                HStack {
                    RecipeEditField(fieldName: "Name", placeholder: "Recipe Name", fieldText: self.$recipeName, size: geometry.size)

                    Spacer()

                    VStack {
                        Text("Image")
                            .font(.custom("HelveticaNeue-Regular", size: 15))
                        .foregroundColor(Color("Light-Gray"))

                        ZStack {
                            if self.recipe.image == nil {
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
                        .padding(.horizontal, 30)

                    }
                }


                RecipeEditField(fieldName: "Time", placeholder: "Time To Make", fieldText: self.$time, size: geometry.size)

                Text("Daily Requirements")
                    .font(.custom("HelveticaNeue-Regular", size: 15))
                    .foregroundColor(Color("Light-Gray"))
                    .padding(.bottom)

                DietryToggle(dietryToggle: self.$isVegitarian, dietryName: "Vegitarian")
                DietryToggle(dietryToggle: self.$isNutFree, dietryName: "Nut Free")
                DietryToggle(dietryToggle: self.$isGlutenFree, dietryName: "Gluten Free")
                
                IngredientMethodPagerView(recipe: self.recipe, currentIndex: 0, addIngredientAction: {
                    self.addIngredientButtonTapped()
                }, saveIngredientActoin: {
                    self.saveIngredientButtonTapped()
                }, addMethodAction: {
                    self.addMethodStepButtonTapped()
                }, saveMethodAction: {
                    self.saveMethodSetpButtonTapped()
                })
            }
        }
    }
    
    // MARK: - View methods
    private func addIngredientButtonTapped() {
        print("added ingredient")
    }
    
    private func saveIngredientButtonTapped() {
        print("ingredient saved")
    }
    
    private func addMethodStepButtonTapped() {
        print("Add step")
    }
    
    private func saveMethodSetpButtonTapped() {
        print("Save Step")
    }
    
    
}

struct DietryToggle: View {
    
    @Binding var dietryToggle: Bool
    var dietryName: String
    
    var body: some View {
        HStack {
            Toggle("", isOn: $dietryToggle)
            .labelsHidden()
            
            Text(dietryName)
                .font(.custom("HelveticaNeue-Bold", size: 30))
                .foregroundColor(dietryToggle ? Color("Lead") : Color("Light-Gray"))
                .animation(.easeIn(duration: 5))
                .padding(.leading)
        }
        .padding(.horizontal, 30)
    }
}

struct RecipeEditField: View, ElencoTextFieldDisplayable {
    
    var fieldName: String
    var placeholder: String
    @Binding var fieldText: String
    var size: CGSize
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(fieldName)
                .font(.custom("HelveticaNeue-Regular", size: 15))
            .foregroundColor(Color("Light-Gray"))
            
            ElencoTextField(text: $fieldText, isFirstResponder: false, textFieldView: self, font: UIFont(name: "HelveticaNeue-Bold", size: 25), color: #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1), placeholder: placeholder)
                .textFieldStyle(PlainTextFieldStyle())
                .foregroundColor(Color("Tungtsen"))
                .accentColor(Color("Teal"))
                .frame(width: size.width * 0.6, height: 50)
        }
        .padding(.horizontal, 30)
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
