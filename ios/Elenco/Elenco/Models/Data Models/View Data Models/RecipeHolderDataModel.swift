//
//  RecipeHolderDataModel.swift
//  Elenco
//
//  Created by James Bernhardt on 01/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

class RecipeHolderDataModel: ObservableObject {
    
    @Published private(set) var editRecipiesIsShown: Bool = false
    
    @Published private(set) var recipeViewIsShown: Bool = false
    
    @Published private(set) var selectedRecipe: Recipe
    
    @Published private var isNewRecipe: Bool = false
    
    init() {
        self.selectedRecipe = Recipe(name: "recipeName", recipeID: UUID(), serves: 0, estimatedTime: "time", ingredients: Ingredients(), method: Instructions())
    }
    
    public func displayEditRecipeView() {
        editRecipiesIsShown = true
        recipeViewIsShown = false
    }
    
    public func displayRecipeView() {
        recipeViewIsShown = true
        editRecipiesIsShown = false
    }
    
    public func configureSelectedRecipe(for recipe: Recipe) {
        isNewRecipe = false
        selectedRecipe = recipe
    }
    
    public func configureNewSelectedRecipe() {
        isNewRecipe = true
        selectedRecipe = Recipe(name: "recipeName", recipeID: UUID(), serves: 0, estimatedTime: "time", ingredients: Ingredients(), method: Instructions())
    }
    
    public func addIngredient(name: String) {
        let ingredient = Ingredient(ingredientID: UUID(), name: name, aisle: "", parentList: nil)
        selectedRecipe.ingredients.append(ingredient)
    }
    
    public func addMethod(for instruction: String) {
        let methodNumber = selectedRecipe.method.count + 1
        let method = RecipeMethod(number: methodNumber, instruction: instruction)
        selectedRecipe.method.append(method)
    }
    
    public func saveRecipe(name: String, time: String) {
        selectedRecipe.name = name
        selectedRecipe.estimatedTime = time
        RecipeDataModel.shared.createRecipe(recipe: selectedRecipe) { (error) in
            if let error = error { print(error.localizedDescription) }
        }
    }
    
    public func getRecipes() -> Recipes {
        return RecipeDataModel.shared.fetchRecipes()
    }
    
    
    // MARK: - Methods To Sort Ingredients and Instructions into sections
    // Return ingredients sorted into alphabetical sections
    public func ingredientsSortedByName() -> [RecipeListViewSection<Ingredient>] {
        let ingredients = selectedRecipe.ingredients
        var sections = [RecipeListViewSection<Ingredient>]()
        let sectionHeaders = Set(ingredients.map({ $0.name.first?.lowercased() ?? ""}))
        
        // Filter ingredients in each section
        for header in sectionHeaders {
            let ingredientsInSection = ingredients.filter({ $0.name.first?.lowercased() ?? "" == header })
            let section = RecipeListViewSection<Ingredient>(title: String(header), content: ingredientsInSection)
            sections.append(section)
        }
        sections = sections.sorted(by: { $0.title < $1.title })
        return sections
    }
    
    // Return Methods sorted into sectinos
    public func methodsSortedIntoSections() -> [RecipeListViewSection<RecipeMethod>] {
        
        let methods = selectedRecipe.method
        var sections = [RecipeListViewSection<RecipeMethod>]()
        for method in methods {
            let section = RecipeListViewSection<RecipeMethod>(title: "\(method.number)", content: [method])
            sections.append(section)
        }
        return sections
    }
}

struct RecipeListViewSection<SectionContent> where SectionContent: Identifiable {
    var title: String
    var content: [SectionContent]
}
