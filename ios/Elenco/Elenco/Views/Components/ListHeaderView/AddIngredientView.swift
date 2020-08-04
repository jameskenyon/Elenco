//
//  AddIngredientView.swift
//  Elenco
//
//  Created by James Kenyon on 27/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI
import UIKit

struct AddIngredientView: View, ElencoTextFieldDisplayable {

    // global observed model
    @EnvironmentObject var listHolderModel: ListHolderDataModel
    // local observed model for getting ingredient data
    @ObservedObject var searchViewModel = SearchViewModel()
    // hold the colour scheme for dark mode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            if listHolderModel.userIsAddingIngredient {
                VStack(alignment: .leading) {
                    HStack {
                        GeometryReader { geometry in
                            ElencoTextField(text: self.$searchViewModel.query, isFirstResponder: self.listHolderModel.userIsAddingIngredient, textFieldView: self, font: UIFont(name: "HelveticaNeue-Bold", size: 22),
                                            color: self.colorScheme == .dark ? UIColor.white : UIColor(named: "Tungsten"))
                            .frame(height: 30)
                            .frame(maxWidth: geometry.size.width - 50)
                            .padding(.top, self.searchViewModel.searchIngredients.count == 0 ? 0:10)
                            .accentColor(Color("Teal"))
                            .foregroundColor(Color("BodyText"))
                            .background(Color("Background"))
                        }
                        .frame(height: 60)
                        if searchViewModel.query.count != 0 {
                            Button(action: {
                                self.addIngredientOrRecipe()
                                self.listHolderModel.userFinishedAddingIngredients()
                            }) {
                                Text("+")
                                    .font(.custom("HelveticaNeue-Bold", size: 34))
                                    .foregroundColor(Color("Orange"))
                            }
                            .padding(.trailing, 20).padding(.bottom, 4)
                            .background(Color("Background"))
                        }
                    }
                    .background(Color("Background"))
                    
                    // display each of the recipe suggestions
                    ForEach(searchViewModel.searchRecipes.indices, id: \.self) { index in
                        RecipeSearchCell(recipe: self.searchViewModel.searchRecipes[index],
                                         query: self.searchViewModel.query)
                            .padding(.top).padding(.bottom)
                            .onTapGesture {
                                self.searchViewModel.query = self.searchViewModel.searchRecipes[index].name.capitalise()
                            }
                    }
                    .background(Color("Background"))
                    
                    // display each of the ingredient suggestions
                    ForEach(searchViewModel.searchIngredients.indices, id: \.self) { index in
                        IngredientSearchCell(ingredient: self.searchViewModel.searchIngredients[index],
                                             index: index, query: self.searchViewModel.query)
                            .padding(.top).padding(.bottom)
                            .background(index == 0 ? Color("Opaque-Teal"):Color("Background"))
                            .onTapGesture {
                                self.searchViewModel.query = self.searchViewModel.searchIngredients[index].name.capitalise()
                            }
                    }
                    .background(Color("Background"))
                }
                .background(Color("Background"))
                .cornerRadius(10)
                .shadow(color: colorScheme == .dark ? .clear : Color("Dark-Gray") , radius: 4)
            }
        }
        .padding()
    }
    
    // decides whether to add ingredient or recipe
    private func addIngredientOrRecipe() {
        // there is at least one recipe that has been found
        if searchViewModel.searchRecipes.count != 0 {
            let searchQuery = searchViewModel.query
            if let recipe = RecipeDataModel.shared.fetchRecipe(forName: searchQuery) {
                self.listHolderModel.window.displayChoiceAlert(title: "Alert", message: "Would you like to add this as a recipe or ingredient?", actionOneTitle: "Ingredient", actionTwoTitle: "Recipe", actionOne: { (action) -> (Void) in
                    self.addIngredient(searchText: searchQuery)
                }) { (action) -> (Void) in
                    self.addRecipe(recipe: recipe)
                }
            }
        } else {
            addIngredient()
        }
        self.listHolderModel.showTickView = true
        hideTextField()
    }
    
    private func addIngredient() {
        let nameAndQuantity = Ingredient.getIngredientNameAndQuantity(searchText:
                   self.searchViewModel.query)
        let name  = nameAndQuantity.0
        let quantity = nameAndQuantity.1
        let aisle = IngredientAPIService.getAisleForIngredient(ingredientName: name)
        self.listHolderModel.addIngredient(ingredient:
            Ingredient(ingredientID: UUID(), name: name, aisle: aisle, quantity: quantity, parentList: self.listHolderModel.list)
        )
    }
    
    private func addIngredient(searchText: String) {
        let nameAndQuantity = Ingredient.getIngredientNameAndQuantity(searchText: searchText)
        let name  = nameAndQuantity.0
        let quantity = nameAndQuantity.1
        let aisle = IngredientAPIService.getAisleForIngredient(ingredientName: name)
        self.listHolderModel.addIngredient(ingredient:
            Ingredient(ingredientID: UUID(), name: name, aisle: aisle, quantity: quantity, parentList: self.listHolderModel.list)
        )
    }
    
    // Add all ingredients from a recipe
    private func addRecipe(recipe: Recipe) {
        for ingredient in recipe.ingredients {
            var ingredientCopy = ingredient.copy()
            ingredientCopy.generateNewID()
            ingredientCopy.parentList = listHolderModel.list
            self.listHolderModel.addIngredient(ingredient: ingredientCopy)
        }
    }

    // hide the text field from the user
    private func hideTextField() {
        withAnimation {
            listHolderModel.userIsAddingIngredient = false
        }
    }
    
    // MARK: ElencoListDisplayable Methods
    
    // do nothing when the user edits text - has to be implemented for protocol.
    public func userDidEditTextField(newValue: String) {}
    
    // Called when the user adds an ingredient by returning on the text field
    public func userDidReturnOnTextField() {
        let query = self.searchViewModel.query
        if query.trimmingCharacters(in: [" "]) != "" {
            if listHolderModel.userHasIngredient(name: query) {
                listHolderModel.window.displayAlert(title: "You already have this ingredient.",
                                                okTitle: "Add anyway") { (alert) -> (Void) in
                                                    self.addIngredientOrRecipe()
                }
            } else {
                addIngredientOrRecipe()
            }
        }
        hideTextField()
    }
    
}

extension AddIngredientView {
    
    class SearchViewModel: ObservableObject {
        
        @Published private(set) var searchIngredients: Ingredients = []
        @Published private(set) var searchRecipes: Recipes = []
        
        @Published var query:String = "" {
            didSet {
                loadIngredientsAndRecipesFor(query: query)
            }
        }
    
        private func loadIngredientsAndRecipesFor(query: String) {
            // user must type at least 2 letters before beginning auto-complete
            if query.count >= 2 {
                let ingredientsResults = IngredientAPIService.getPossibleIngredientsFor(query: query)
                let recipesResults = RecipeDataModel.shared.fetchRecipes(withName: query)
                DispatchQueue.main.async {
                    withAnimation { () -> () in
                        self.searchIngredients = ingredientsResults
                        self.searchRecipes = recipesResults
                    }
                }
            } else {
                withAnimation { () -> () in
                    self.searchIngredients = []
                    self.searchRecipes = []
                }
            }
        }
    }
}

/// Represents an ingredient in the search view
struct IngredientSearchCell: View {
    
    // Properties
    var ingredient: Ingredient
    var index: Int
    var query: String
    
    var body: some View {
        HStack {
            Text("\(index + 1)")
                .padding(.trailing).padding(.leading, 30)
                .font(.custom("HelveticaNeue-Regular", size: 18))
                .foregroundColor(index == 0 ?
                    Color("Dark-Gray") : Color("Light-Gray"))
            SemiBoldLabel(text: ingredient.name.lowercased(), query: query.lowercased(),
                          font: .custom("HelveticaNeue-Regular", size: 20))
            Spacer()
        }
    }
}

/// Represents a recipe in the search view
struct RecipeSearchCell: View {
    
    // Properties
    var recipe: Recipe
    var query: String
    
    var body: some View {
        HStack {
            Text("Recipe")
                .padding(.trailing).padding(.leading, 30)
                .font(.custom("HelveticaNeue-Regular", size: 18))
                .foregroundColor(Color("Teal"))
            SemiBoldLabel(text: recipe.name.lowercased(), query: query.lowercased(),
                          font: .custom("HelveticaNeue-Regular", size: 20))
            Spacer()
        }
    }
}

#if DEBUG
struct AddIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        AddIngredientView()
    }
}
#endif
