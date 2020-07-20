//
//  List.swift
//  Elenco
//
//  Created by James Kenyon on 09/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation

/*
 
 The List class will hold an array of ingredients and
 also model a general list in the app. The user is allowed to have
 multiple lists which they can populate with ingredients.
 
 */

struct ElencoList: Codable, Identifiable, Hashable  {
    
    var name: String
    let id: UUID
    var listID: UUID
    var ingredients: Ingredients
    
    let isSharedList: Bool
    
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
    
    // get list from store
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
    
    // Return copy of list
    public func copy() -> ElencoList {
        return ElencoList(name: self.name, id: UUID(), listID: self.listID, ingredients: self.ingredients)
    }

}
