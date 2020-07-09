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
    
    let name: String
    let id: UUID
    var ingredients: Ingredients
    
    let isSharedList: Bool = false
    
    init(name: String, id: UUID = UUID(), ingredients: Ingredients = []) {
        self.name = name
        self.id = id
        self.ingredients = ingredients
    }
    
    // ⚠️ go to the data store and get the ingredients for
    // a given list.
    public mutating func updateIngredients(newIngredients: Ingredients) {
        self.ingredients = newIngredients
    }
    
}
