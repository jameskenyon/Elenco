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
    var image: Image
    
    /// The dietry requirements that this recipe meets.
    var dietaryRequirements: String?
    
    // MARK: Inits
    
    /// Init recipe when in app using all the default fields.
    init(name: String, id: UUID = UUID(), recipeID: UUID, serves: Int, ingredients: Ingredients, isShared: Bool, estimatedTime: String, method: Instructions, dietaryRequirements: String? = nil) {
        self.name = name
        self.id = id
        self.recipeID = recipeID
        self.serves = serves
        self.ingredients = ingredients
        self.isSharedRecipe = isShared
        self.estimatedTime = estimatedTime
        self.method = method
        self.dietaryRequirements = dietaryRequirements
        
        // ⚠️ set image as deafult for now
        self.image = Image("tomatoPasta")
    }
    
    /**
     Init recipe from coredata store.
     
     - Parameters:
        - recipeStore: The recipe store gathered from core data
     */
    // ⚠️ create method to init recipes from data store.
//    init(recipeStore: RecipeStore) {
//
//    }
    
    // MARK: Public Interface
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.recipeID == rhs.recipeID
    }
    
    static func getRecipes() -> Recipes {
        return [
            Recipe(name: "Tomato Pasta", recipeID: UUID(), serves: 2, ingredients:
                [Ingredient(ingredientID: UUID(), name: "Tomato", aisle: "Produce", parentList: nil),
                 Ingredient(ingredientID: UUID(), name: "Pasta", aisle: "Pasta", parentList: nil),
                 Ingredient(ingredientID: UUID(), name: "Garlic", aisle: "Produce", parentList: nil),
                 Ingredient(ingredientID: UUID(), name: "Tomato Sauce", aisle: "Sauces", parentList: nil)
                ],
                   isShared: false, estimatedTime: "20mins", method: [
                    RecipeMethod(number: 1, instruction: "Do this and then this and then this."),
                    RecipeMethod(number: 2, instruction: "Do this and then this and then this."),
                    RecipeMethod(number: 3, instruction: "Do this and then this and then this."),
                    RecipeMethod(number: 4, instruction: "Do this and then this and then this."),
            ]),
            Recipe(name: "Tomato Pasta", recipeID: UUID(), serves: 2, ingredients:
                [Ingredient(ingredientID: UUID(), name: "Tomato", aisle: "Produce", parentList: nil),
                 Ingredient(ingredientID: UUID(), name: "Pasta", aisle: "Pasta", parentList: nil),
                 Ingredient(ingredientID: UUID(), name: "Garlic", aisle: "Produce", parentList: nil),
                 Ingredient(ingredientID: UUID(), name: "Tomato Sauce", aisle: "Sauces", parentList: nil)
                ],
                   isShared: false, estimatedTime: "20mins", method: [
                    RecipeMethod(number: 1, instruction: "Do this and then this and then this."),
                    RecipeMethod(number: 2, instruction: "Do this and then this and then this."),
                    RecipeMethod(number: 3, instruction: "Do this and then this and then this."),
                    RecipeMethod(number: 4, instruction: "Do this and then this and then this."),
            ]),
            Recipe(name: "Tomato Pasta", recipeID: UUID(), serves: 2, ingredients:
                [Ingredient(ingredientID: UUID(), name: "Tomato", aisle: "Produce", parentList: nil),
                 Ingredient(ingredientID: UUID(), name: "Pasta", aisle: "Pasta", parentList: nil),
                 Ingredient(ingredientID: UUID(), name: "Garlic", aisle: "Produce", parentList: nil),
                 Ingredient(ingredientID: UUID(), name: "Tomato Sauce", aisle: "Sauces", parentList: nil)
                ],
                   isShared: false, estimatedTime: "20mins", method: [
                    RecipeMethod(number: 1, instruction: "Do this and then this and then this."),
                    RecipeMethod(number: 2, instruction: "Do this and then this and then this."),
                    RecipeMethod(number: 3, instruction: "Do this and then this and then this."),
                    RecipeMethod(number: 4, instruction: "Do this and then this and then this."),
            ])
        ]
    }
    
}

/// Represents a single instruction in the recipe method
struct RecipeMethod: Identifiable {
    var id = UUID()
    var number: Int
    var instruction: String
}

typealias Instructions = [RecipeMethod]
typealias Recipes = [Recipe]
