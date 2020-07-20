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
    var name: String
    let id = UUID()
    let aisle: String
    let ingredientID: UUID

    var quantity: String?
    var parentList: ElencoList?
    
    var completed: Bool = false
    
    init(ingredientID: UUID, name: String, aisle: String, parentList: ElencoList?) {
        self.ingredientID = ingredientID
        self.name       = name
        self.aisle      = aisle
        self.parentList = parentList
    }
    
    init(ingredientID: UUID, name: String, aisle: String, quantity: String?, parentList: ElencoList?) {
        self.ingredientID = ingredientID
        self.name         = name
        self.aisle        = aisle
        self.quantity     = quantity
        self.parentList   = parentList
    }
    
    init(ingredientID: UUID, name: String, aisle: String, quantity: String?, parentList: ElencoList?, completed: Bool) {
        self.ingredientID = ingredientID
        self.name         = name
        self.aisle        = aisle
        self.quantity     = quantity
        self.parentList   = parentList
        self.completed    = completed
    }
    
    init(ingredientStore: IngredientStore, parentList: ElencoList) {
        self.ingredientID = ingredientStore.ingredientID ?? UUID()
        self.name         = ingredientStore.name ?? ""
        self.aisle        = ingredientStore.aisle ?? ""
        self.quantity     = ingredientStore.quantity
        self.completed    = ingredientStore.completed
        self.parentList   = parentList
    }
    
    init(ingredientStore: IngredientStore) {
        self.ingredientID = ingredientStore.ingredientID ?? UUID()
        self.name         = ingredientStore.name ?? ""
        self.aisle        = ingredientStore.aisle ?? ""
        self.quantity     = ingredientStore.quantity
        self.completed    = ingredientStore.completed
        self.parentList   = ElencoList(name: ingredientStore.list?.name ?? "", id: ingredientStore.list?.id ?? UUID(), listID: ingredientStore.list?.listID ?? UUID())
    }
    
    public func copy() -> Ingredient {
        return Ingredient(ingredientID: self.ingredientID, name: self.name, aisle: self.aisle, quantity: self.quantity, parentList: self.parentList, completed: self.completed)
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
        if name.count != 0 {
            name.removeLast()
        }
        return (name, quantity == "" ? "1": quantity)
    }
    
    // check that the name is valid
    public static func nameIsValid(name: String) -> Bool {
        return !stringContainsNumber(str: name)
    }
    
    // checks that new quantity is value
    public static func quantityIsValid(quantity: String) -> Bool {
        return stringContainsNumber(str: quantity) && quantity.count <= 6
    }
    
    // format a quantity
    public static func formatQuantity(quantity: String) -> String {
        return quantity.replacingOccurrences(of: " ", with: "")
    }
    
    public static func formatName(name: String) -> String {
        return name.capitalise()
    }
    
    private static func stringContainsNumber(str: String) -> Bool {
        let numberRegEx = ".*[0-9]+.*"
        let testCase = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        return testCase.evaluate(with: str)
    }
    
}

typealias Ingredients = [Ingredient]
