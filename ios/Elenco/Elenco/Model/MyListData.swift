//
//  MyListData.swift
//  Elenco
//
//  Created by James Kenyon on 30/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation
import UIKit

/*
    
 Hold all the data for the MyListDataView in this class.
 This means that there is only one view for all the subviews to access
 and all the data is in one place.

 */

class MyListData: ObservableObject {
    
    @Published private(set) var ingredients: Ingredients
    @Published private(set) var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        self.ingredients = []
        self.ingredients = loadLocalIngredientList()
    }
    
    // MARK: Public Interface
    
    public func addIngredient(ingredient: Ingredient) {
        self.ingredients.append(ingredient)
        self.saveIngredient(ingredinet: ingredient)
    }
    
    // Returns:
    //      True if the user has this ingredient in their
    //      list already.
    public func userHasIngredient(name: String) -> Bool {
        let ingredientAndQuantity = Ingredient.getIngredientNameAndQuantity(searchText: name)
        for ingredient in ingredients {
            if ingredient.name.lowercased() == ingredientAndQuantity.0.lowercased() {
                return true
            }
        }
        return false
    }
    
    // MARK: Private Interface
    
    // ⚠️ update this to get the proper list of ingredients from CoreData
    private func loadLocalIngredientList() -> Ingredients {
        return [
            Ingredient(name: "carrot", id: 1, aisle: "Veg", quantity: "1kg"),
            Ingredient(name: "butternut Squash", id: 2, aisle: "Veg", quantity: "2kg"),
            Ingredient(name: "salad Leaves", id: 3, aisle: "Veg", quantity: "5"),
            Ingredient(name: "summer Fruits", id: 4, aisle: "Fruit", quantity: "10g"),
            Ingredient(name: "tangerine", id: 5, aisle: "Fruit", quantity: "1"),
            Ingredient(name: "toast", id: 10, aisle: "Cooked", quantity: "10"),
        ]
    }
    
    // ⚠️ save the ingredient to the core data model
    private func saveIngredient(ingredinet: Ingredient) {
        
    }
    
}
