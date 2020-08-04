//
//  Recipe.swift
//  Elenco
//
//  Created by James Kenyon on 01/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation
import SwiftUI

/**
 The Recipe structure will encapsulate an recipe in the app.
 
 It will hold all information about a recipe that will be required to render
 a recipe in the app.

 - Author: James Kenyon
*/

struct Recipe: Identifiable {
    
    /// The id of the ingredient for in-app
    var id = UUID()
    
    /// The id of the recipe when stored in core data.
    var recipeID: UUID
    
    /// The name of the recipe
    var name: String
    
    /// How many people this recipe serves
    var serves: Int
    
    /// The ingredients that make up this recipe
    var ingredients: Ingredients
    
    /// Whether the recipe is being shared
    var isSharedRecipe: Bool
    
    /// The estimated time that the recipe will take to make
    var estimatedTime: String
    
    /// The instructions that the user will need to make the recipe
    var method: Instructions
    
    /// The image for the recipe
    var image: UIImage?
    
    /// The dietry requirements that this recipe meets.
    var dietaryRequirements: String?
    
    // MARK: Inits
    
    /// Init recipe when in app using all the default fields.
    init(name: String, id: UUID = UUID(), recipeID: UUID, serves: Int, isShared: Bool = false, estimatedTime: String,
         dietaryRequirements: String? = nil, image: UIImage? = nil, ingredients: Ingredients, method: Instructions) {
        self.name = name.lowercased()
        self.id = id
        self.recipeID = recipeID
        self.serves = serves
        self.isSharedRecipe = isShared
        self.estimatedTime = estimatedTime
        self.dietaryRequirements = dietaryRequirements
        self.image = image
        self.ingredients = ingredients
        self.method = method
    }
    
    /**
     Init recipe from coredata store.
     
     - Parameters:
        - recipeStore: The recipe store gathered from core data
     */
     
    init(recipeStore: RecipeStore) {
        self.name = recipeStore.name?.lowercased() ?? ""
        self.id = recipeStore.id ?? UUID()
        self.recipeID = recipeStore.recipeID ?? UUID()
        self.serves = Int(recipeStore.serves)
        self.isSharedRecipe = recipeStore.isShared
        self.estimatedTime = recipeStore.estimatedTime ?? ""
        self.dietaryRequirements = recipeStore.dietaryRequirements
        if let data = recipeStore.image {
            self.image = UIImage(data: data)
        }
        self.ingredients = Recipe.getIngredientsFromJSONString(ingredientsJSON: recipeStore.ingredients ?? "")
        self.method = Recipe.getRecipeFromJSONString(methodJSON: recipeStore.method ?? "")
    }
    
    // MARK: Public Interface
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.recipeID == rhs.recipeID
    }
    
    // ⚠️ Remove after testing
    /// Method for testing the recipes - returns dummy array of recipes
    static func getRecipes() -> Recipes {
        return [
            Recipe(name: "Tomato Pasta", recipeID: UUID(), serves: 2, estimatedTime: "20mins", image: UIImage(named: "tomatoPasta"), ingredients:
                [Ingredient(ingredientID: UUID(), name: "Tomato", aisle: "Produce", parentList: nil),
                 Ingredient(ingredientID: UUID(), name: "Pasta", aisle: "Pasta", parentList: nil),
                 Ingredient(ingredientID: UUID(), name: "Garlic", aisle: "Produce", parentList: nil),
                 Ingredient(ingredientID: UUID(), name: "Tomato Sauce", aisle: "Sauces", parentList: nil)
                ], method: [
                    RecipeMethod(number: 1, instruction: "Do this and then this and then this."),
                    RecipeMethod(number: 2, instruction: "Do this and then this and then this."),
                    RecipeMethod(number: 3, instruction: "Do this and then this and then this."),
                    RecipeMethod(number: 4, instruction: "Do this and then this and then this."),
            ]),
            Recipe(name: "Tomato Pasta", recipeID: UUID(), serves: 2, estimatedTime: "20mins", ingredients:
                [Ingredient(ingredientID: UUID(), name: "Tomato", aisle: "Produce", parentList: nil),
                 Ingredient(ingredientID: UUID(), name: "Pasta", aisle: "Pasta", parentList: nil),
                 Ingredient(ingredientID: UUID(), name: "Garlic", aisle: "Produce", parentList: nil),
                 Ingredient(ingredientID: UUID(), name: "Tomato Sauce", aisle: "Sauces", parentList: nil)
                ], method: [
                    RecipeMethod(number: 1, instruction: "Do this and then this and then this."),
                    RecipeMethod(number: 2, instruction: "Do this and then this and then this."),
                    RecipeMethod(number: 3, instruction: "Do this and then this and then this."),
                    RecipeMethod(number: 4, instruction: "Do this and then this and then this."),
            ]),
            Recipe(name: "Tomato Pasta", recipeID: UUID(), serves: 2, estimatedTime: "20mins", ingredients:
                [Ingredient(ingredientID: UUID(), name: "Tomato", aisle: "Produce", parentList: nil),
                 Ingredient(ingredientID: UUID(), name: "Pasta", aisle: "Pasta", parentList: nil),
                 Ingredient(ingredientID: UUID(), name: "Garlic", aisle: "Produce", parentList: nil),
                 Ingredient(ingredientID: UUID(), name: "Tomato Sauce", aisle: "Sauces", parentList: nil)
                ], method: [
                    RecipeMethod(number: 1, instruction: "Do this and then this and then this."),
                    RecipeMethod(number: 2, instruction: "Do this and then this and then this."),
                    RecipeMethod(number: 3, instruction: "Do this and then this and then this."),
                    RecipeMethod(number: 4, instruction: "Do this and then this and then this."),
            ]),
        ]
    }
    
}

extension Recipe {
    
    // MARK: JSON Core Data Methods
    
    /// Convert the current recipe's ingredients to a string in JSON format
    public func getIngredientsAsJSONString() -> String {
        var formattedString: String = "["
        let jsonEncoder = JSONEncoder()
        do {
            for ingredient in self.ingredients {
                let jsonData = try jsonEncoder.encode(ingredient)
                if let str = String(data: jsonData, encoding: .utf8) {
                    formattedString += (str + ",")
                }
            }
            formattedString += "]"
        } catch {} // handle error
        return formattedString
    }
    
    /// Convert the current recipe's method to a string in JSON format
    public func getMethodAsJSONString() -> String {
        var formattedString: String = "["
        let jsonEncoder = JSONEncoder()
        do {
            for instruction in self.method {
                let jsonData = try jsonEncoder.encode(instruction)
                if let str = String(data: jsonData, encoding: .utf8) {
                    formattedString += (str + ",")
                }
            }
            formattedString += "]"
        } catch {} // handle error
        return formattedString
    }
    
    /// Get recipe method from a json stirng that is saved in core data
    public static func getRecipeFromJSONString(methodJSON: String) -> Instructions {
        do {
            guard let data = methodJSON.data(using: .utf8) else { return [] }
            let recipeMethod = try JSONDecoder().decode(Instructions.self, from: data)
            return recipeMethod
        } catch {
            return []
        }
    }
    
    /// Get ingredients from a json string that is saved in core data
    public static func getIngredientsFromJSONString(ingredientsJSON: String) -> Ingredients {
        do {
            guard let data = ingredientsJSON.data(using: .utf8) else { return [] }
            let recipeIngredients = try JSONDecoder().decode(Ingredients.self, from: data)
            return recipeIngredients
        } catch {
            return []
        }
    }
    
    // MARK: Private Interface
    
}

/// Represents a single instruction in the recipe method
struct RecipeMethod: Codable, Identifiable {
    var id = UUID()
    var number: Int
    var instruction: String
}

typealias Instructions = [RecipeMethod]
typealias Recipes = [Recipe]
