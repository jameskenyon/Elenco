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
    
    @Published private(set) var isNewRecipe: Bool = false
    
    @Published private(set) var recipes: Recipes
    
    @Published public var recipeSearchIsFirstResponder: Bool = false
    
    init() {
        self.recipes = RecipeDataModel.shared.fetchRecipes()
        self.selectedRecipe = Recipe(name: "recipeName", recipeID: UUID(), serves: 0, estimatedTime: "time", ingredients: Ingredients(), method: Instructions())
    }
    
    // MARK: - View Configuration Methods
    public func displayEditRecipeView() {
        editRecipiesIsShown = true
        recipeViewIsShown = false
    }
    
    public func displayRecipeView() {
        recipeViewIsShown = true
        editRecipiesIsShown = false
    }
    
    public func hideViews() {
        recipeViewIsShown = false
        editRecipiesIsShown = false
    }
    
    public func configureSelectedRecipe(for recipe: Recipe) {
        isNewRecipe = false
        selectedRecipe = recipe
    }
    
    public func configureNewSelectedRecipe() {
        isNewRecipe = true
        selectedRecipe = Recipe(name: "", recipeID: UUID(), serves: 0, estimatedTime: "", ingredients: Ingredients(), method: Instructions())
    }
    
    // MARK: - Access to Core data model
    public func addIngredient(name: String, quantity: String) {
        let ingredient = Ingredient(ingredientID: UUID(), name: name, aisle: "", quantity: quantity, parentList: nil)
        selectedRecipe.ingredients.append(ingredient)
    }
    
    public func addMethod(for instruction: String) {
        let methodNumber = selectedRecipe.method.count + 1
        let method = RecipeMethod(number: methodNumber, instruction: instruction)
        selectedRecipe.method.append(method)
    }
    
    public func saveRecipe(name: String, time: String, serves: String, image: UIImage) {
        selectedRecipe.name = name
        selectedRecipe.estimatedTime = time
        selectedRecipe.serves = Int(serves) ?? 1
        selectedRecipe.image = image
        RecipeDataModel.shared.createRecipe(recipe: selectedRecipe) { (error) in
            if let error = error { print(error.localizedDescription) }
            self.recipes.append(self.selectedRecipe)
        }
    }
    
    // Deletes the selected recipe
    public func deleteRecipe() {
        recipes.removeAll(where: { $0.id == selectedRecipe.id })
        RecipeDataModel.shared.delete(recipe: selectedRecipe) { (error) in
            if let error = error { print(error.localizedDescription) }
        }
    }
    
    // Delete a recipe
    public func delete(recipe: Recipe) {
        recipes.removeAll(where: { $0.id == recipe.id })

        RecipeDataModel.shared.delete(recipe: recipe) { (error) in
            if let error = error { print(error.localizedDescription) }
        }
    }
    
    // Update recipe in Core data
    public func updateRecipe(name: String, time: String, serves: String, image: UIImage) {
        selectedRecipe.name = name
        selectedRecipe.estimatedTime = time
        selectedRecipe.serves = Int(serves) ?? 1
        selectedRecipe.image = image
        RecipeDataModel.shared.update(recipe: selectedRecipe) { (error) in
            if let error = error { print(error.localizedDescription) }
        }
    }
    
    public func getRecipes() -> Recipes {
        return RecipeDataModel.shared.fetchRecipes()
    }
    
    // MARK: - Query methods
    public func search(text: String) -> Recipes {
        if !text.isEmpty {
            return recipes.filter({ $0.name.lowercased().contains(text.lowercased()) })
        }
        return recipes
    }
    
    
    // MARK: - Methods To Sort Ingredients and Instructions into sections
    // Return ingredients sorted into alphabetical sections
    public func ingredientsSortedByName() -> [ListViewSection<Ingredient>] {
        let ingredients = selectedRecipe.ingredients
        var sections = [ListViewSection<Ingredient>]()
        let sectionHeaders = Set(ingredients.map({ $0.name.first?.lowercased() ?? ""}))
        
        // Filter ingredients in each section
        for header in sectionHeaders {
            let ingredientsInSection = ingredients.filter({ $0.name.first?.lowercased() ?? "" == header })
            let section = ListViewSection<Ingredient>(title: String(header), content: ingredientsInSection)
            sections.append(section)
        }
        sections = sections.sorted(by: { $0.title < $1.title })
        return sections
    }
    
    // Return Methods sorted into sectinos
    public func methodsSortedIntoSections() -> [ListViewSection<RecipeMethod>] {
        
        let methods = selectedRecipe.method
        var sections = [ListViewSection<RecipeMethod>]()
        for method in methods {
            let section = ListViewSection<RecipeMethod>(title: "\(method.number)", content: [method])
            sections.append(section)
        }
        return sections
    }
    
    // Return recipes sorted into sectinos
    public func recipeSections(for recipes: Recipes) -> [ListViewSection<Recipe>] {
       var sections = [ListViewSection<Recipe>]()
       let sectionHeaders = Set(recipes.map({ $0.name.first?.lowercased() ?? ""}))
       
       // Filter ingredients in each section
       for header in sectionHeaders {
           let ingredientsInSection = recipes.filter({ $0.name.first?.lowercased() ?? "" == header })
           let section = ListViewSection<Recipe>(title: String(header), content: ingredientsInSection)
           sections.append(section)
       }
       sections = sections.sorted(by: { $0.title < $1.title })
       return sections
    }
}
