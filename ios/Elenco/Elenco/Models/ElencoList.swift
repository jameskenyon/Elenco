//
//  List.swift
//  Elenco
//
//  Created by James Kenyon on 09/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation

/**
 The List class will hold an array of ingredients and
 also model a general list in the app. The user is allowed to have
 multiple lists which they can populate with ingredients.

 - Author: James Kenyon
*/

struct ElencoList: Codable, Identifiable, Hashable  {
    
    // MARK: Properties
    
    /// The name of the list.
    var name: String
    
    /// The id of the list for Lists in app.
    let id: UUID
    
    /// The unique listID for referencing in app.
    var listID: UUID
    
    /// The ingredients that this list contains.
    var ingredients: Ingredients
    
    /// Whether the list is a shared list and available online.
    let isSharedList: Bool
    
    // MARK: Inits
    
    init(name: String, id: UUID = UUID(), listID: UUID = UUID(), ingredients: Ingredients = []) {
        self.name = name
        self.id = id
        self.listID = listID
        self.ingredients = ingredients
        isSharedList = false
    }
    
    init(listStore: ListStore) {
        self.name = listStore.name ?? ""
        self.id = listStore.id ?? UUID()
        self.listID = listStore.listID ?? UUID()
        self.isSharedList = listStore.isShared
        
        self.ingredients = []
        self.ingredients = getIngredientsFrom(listStore: listStore)
    }
    
    // MARK: Public Interface
    
    /**
     Get ingredients for list from the store.
     
     - Parameter listStore: The list store that will be found from CoreData.
     
     - Returns: The Ingredients found in this list.
     */
    public func getIngredientsFrom(listStore: ListStore) -> Ingredients {
        if let ingredientStores = listStore.ingredients?.allObjects {
            var ingredients: Ingredients = []
            for store in ingredientStores {
                if let store = store as? IngredientStore {
                    ingredients.append(
                        Ingredient(ingredientStore: store, parentList: self)
                    )
                }
            }
            return ingredients
        }
        return []
    }
    
    /// Return a copy of the list.
    public func copy() -> ElencoList {
        return ElencoList(name: self.name, id: UUID(), listID: self.listID, ingredients: self.ingredients)
    }

}
