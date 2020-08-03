//
//  EditRecipeView.swift
//  Elenco
//
//  Created by James Bernhardt on 02/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct EditRecipeView: View {
    
    @EnvironmentObject var recipeDataModel: RecipeHolderDataModel
    @EnvironmentObject var listHolderDataModel: ListHolderDataModel
    
    @State var recipeName: String = ""
    @State var time: String = ""
    @State var serves: String = ""
    @State var isVegitarian: Bool = false
    @State var isNutFree: Bool = false
    @State var isGlutenFree: Bool = false
    
    init() {
        UISwitch.appearance().onTintColor = #colorLiteral(red: 0.3696106672, green: 0.7883469462, blue: 0.6629261374, alpha: 1)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                
                HStack {
                    RecipeEditField(fieldName: "Name", placeholder: "Recipe Name", fieldText: self.$recipeName, size: geometry.size, keyboardType: .default)

                    Spacer()

                    VStack {
                        Text("Image")
                            .font(.custom("HelveticaNeue-Regular", size: 15))
                        .foregroundColor(Color("Light-Gray"))

                        ZStack {
                            if self.recipeDataModel.selectedRecipe.image == nil {
                                RoundedRectangle(cornerRadius: 35)
                                .foregroundColor(Color("Light-Gray"))
                                .frame(width: 70, height: 70)
                            } else {
                                Image(uiImage: self.recipeDataModel.selectedRecipe.image!)
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

                RecipeEditField(fieldName: "Time", placeholder: "Time To Make", fieldText: self.$time, size: geometry.size, keyboardType: .numberPad)
                
                RecipeEditField(fieldName: "Serves", placeholder: "How Many People", fieldText: self.$serves, size: geometry.size, keyboardType: .numberPad)

                Text("Daily Requirements")
                    .font(.custom("HelveticaNeue-Regular", size: 15))
                    .foregroundColor(Color("Light-Gray"))
                    .padding(.bottom)

                RequirmentToggleView(dietryToggle: self.$isVegitarian, dietryName: "Vegitarian")
                RequirmentToggleView(dietryToggle: self.$isNutFree, dietryName: "Nut Free")
                RequirmentToggleView(dietryToggle: self.$isGlutenFree, dietryName: "Gluten Free")
                
                IngredientMethodPagerView(addIngredientAction: {
                    self.addIngredientButtonTapped()
                }, saveIngredientActoin: {
                    self.saveRecipe()
                }, addMethodAction: {
                    self.addMethodStepButtonTapped()
                }, saveMethodAction: {
                    self.saveRecipe()
                })
            }
            .onAppear {
                self.recipeName = self.recipeDataModel.selectedRecipe.name
                self.time = self.recipeDataModel.selectedRecipe.estimatedTime
                let recipeServes = self.recipeDataModel.selectedRecipe.serves
                self.serves = recipeServes != 0 ? "\(recipeServes)" : ""
            }
        }
    }
    
    // MARK: - View methods
    
    // Enable user to input ingredient name and display in list
    private func addIngredientButtonTapped() {
        // MARK: TODO custom input field
        listHolderDataModel.window.displayAlertWithTextField(title: "Add Ingredient", message: "Add Ingredient to this recipe", placeholder: "Add Ingredient") { (ingredientString) in
            guard let ingredientString = ingredientString   else { return }
            self.recipeDataModel.addIngredient(name: ingredientString)
        }
    }
    
    // Enable user to add a instruction to recipe
    private func addMethodStepButtonTapped() {
        // MARK: TODO custom input field
        listHolderDataModel.window.displayAlertWithTextField(title: "Add Method", message: "Add a method step to this recipe", placeholder: "Add Method") { (methodString) in
            guard let methodString = methodString else { return }
            self.recipeDataModel.addMethod(for: methodString)
        }
    }
    
    // Save recipe to core data and stop showing edit recipe page
    private func saveRecipe() {
        if recipeDataModel.isNewRecipe {
            recipeDataModel.saveRecipe(name: recipeName, time: time, serves: serves)
        } else {
            recipeDataModel.updateRecipe(name: recipeName, time: time, serves: serves)
        }
        recipeDataModel.hideViews()
    }
}
