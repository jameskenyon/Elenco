//
//  Ingredient.swift
//  Elenco
//
//  Created by James Kenyon on 27/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation

/*
 
 The Ingredient structure will encapsulate an ingredient in the app.
 It will hold all of the information about an ingredient including:
 its name, the quantity that the user has specified and the aisle
 it would commonly be found down (in the supermarket).

 */

struct Ingredient: Codable, Identifiable, Hashable {
    // properties for the json decoder
    let name: String
    let id = UUID()
    let aisle: String

    var quantity: String?
    var parentList: ElencoList?
    
    var completed: Bool = false
    
    init(name: String, aisle: String, parentList: ElencoList?) {
        self.name       = name
        self.aisle      = aisle
        self.parentList = parentList
    }
    
    init(name: String, aisle: String, quantity: String?, parentList: ElencoList?) {
        self.name       = name
        self.aisle      = aisle
        self.quantity   = quantity
        self.parentList = parentList
    }
    
    init(name: String, aisle: String, quantity: String?, parentList: ElencoList?, completed: Bool) {
        self.name       = name
        self.aisle      = aisle
        self.quantity   = quantity
        self.parentList = parentList
        self.completed  = completed
    }
    
    init(ingredientStore: IngredientStore) {
        self.name      = ingredientStore.name ?? ""
        self.aisle     = ingredientStore.aisle ?? ""
        self.quantity  = ingredientStore.quantity
        self.completed = ingredientStore.completed
    }
    
    public func copy() -> Ingredient {
        return Ingredient(name: self.name, aisle: self.aisle, quantity: self.quantity, parentList: self.parentList, completed: self.completed)
    }
}

extension Ingredient {
    
    // get an ingredient name from a
    // Returns:
    //        (name, quantity)
    public static func getIngredientNameAndQuantity(searchText: String) -> (String, String) {
        //split the string
        let formattedSearchText = searchText.split(separator: " ")
        var name     = ""
        var quantity = ""
        for text in formattedSearchText {
            if stringContainsNumber(str: String(text)) {
                quantity += text
            } else {
                name += text + " "
            }
        }
        name.removeLast()
        return (name, quantity == "" ? "1": quantity)
    }
    
    private static func stringContainsNumber(str: String) -> Bool {
        let numberRegEx = ".*[0-9]+.*"
        let testCase = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        return testCase.evaluate(with: str)
    }
    
}

typealias Ingredients = [Ingredient]
