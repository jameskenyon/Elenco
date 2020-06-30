//
//  MyListData.swift
//  Elenco
//
//  Created by James Kenyon on 30/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation

/*
    
 Hold all the data for the MyListDataView in this class.
 This means that there is only one view for all the subviews to access
 and all the data is in one place.

 */

class MyListData: ObservableObject {
    
    @Published private(set) var ingredients: Ingredients
    
    init() {
        self.ingredients = []
        self.ingredients = loadLocalIngredientList()
    }
    
    // MARK: Public Interface
    
    public func addIngredient(ingredient: Ingredient) {
        self.ingredients.append(ingredient)
        self.saveIngredient(ingredinet: ingredient)
    }
    
    // MARK: Private Interface
    
    // ⚠️ update this to get the proper list of ingredients from CoreData
    private func loadLocalIngredientList() -> Ingredients {
        return [
            Ingredient(name: "Carrot", id: 1, aisle: "Veg", quantity: "1kg"),
            Ingredient(name: "Butternut Squash", id: 2, aisle: "Veg", quantity: "2kg"),
            Ingredient(name: "Salad Leaves", id: 3, aisle: "Veg", quantity: "5"),
            Ingredient(name: "Summer Fruits", id: 4, aisle: "Fruit", quantity: "10g"),
            Ingredient(name: "Tangerine", id: 5, aisle: "Fruit", quantity: "1"),
            Ingredient(name: "Toast", id: 10, aisle: "Cooked", quantity: "10"),
        ]
    }
    
    // ⚠️ save the ingredient to the core data model
    private func saveIngredient(ingredinet: Ingredient) {
        
    }
    
}
