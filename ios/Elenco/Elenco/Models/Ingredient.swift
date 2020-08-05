//
//  Ingredient.swift
//  Elenco
//
//  Created by James Kenyon on 27/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation

/**
 The Ingredient structure will encapsulate an ingredient in the app.
 
 It will hold all of the information about an ingredient including:
 its name, the quantity that the user has specified and the aisle
 it would commonly be found down (in the supermarket).

 - Author: James Kenyon
*/

struct Ingredient: Codable, Identifiable, Hashable {
    
    // MARK: Properties
    
    /// The name of the ingredient
    var name: String
    
    /// The id of the ingredient for Lists.
    private(set) var id = UUID()
    
    /// The aisle that the ingredient can be found in
    let aisle: String
    
    /// The specific ingredient ID that is used in app.
    private(set) var ingredientID: UUID

    /// The quantity of the current ingredient
    var quantity: String?

    /// The parent list that this ingredient belongs to
    var parentList: ElencoList?
    
    /// Whether the ingredient is marked as completed or not.
    var completed: Bool = false
    
    /// The unit of the ingredient from the quantity string
    var unit: String {
        var charSet = CharacterSet()
        charSet.formUnion(.decimalDigits)
        charSet.insert(charactersIn: ".")
        charSet.insert(charactersIn: ",")
        return self.quantity?.components(separatedBy: charSet)
            .joined().lowercased() ?? ""
    }
    
    /// The raw integer quantity of the ingredient
    var rawQuantity: Float {
        return Float(self.quantity?.components(separatedBy: .letters).joined() ?? "1") ?? 1
    }
    
    // MARK: Inits
    
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
    
    // MARK: Public Interface
    
    /**
     Make a copy of the current ingredient.
     
     - Returns: A copy of this instance that can be editied and sent around the app.
     */
    public func copy() -> Ingredient {
        return Ingredient(ingredientID: self.ingredientID, name: self.name, aisle: self.aisle, quantity: self.quantity, parentList: self.parentList, completed: self.completed)
    }
    
    /// Add the quantities of two ingredients.
    public mutating func addIngredient(ingredient: Ingredient) -> Bool {
        if self.unit == ingredient.unit && self.name.lowercased() == ingredient.name.lowercased() {
            self.quantity = (rawQuantity + ingredient.rawQuantity).clean + unit
            return true
        }
        return false
    }
    
    /// Generate a new id and ingredientID for the ingredient
    public mutating func generateNewID() {
        self.id = UUID()
        self.ingredientID = UUID()
    }
}

extension Ingredient {
    
    /**
     Get the ingredient name and quantity from user search text.
     
     - Parameter searchText: the search text that the user has entered.
     
     - Returns: The name and quantity of the ingredient in tuple form: (name, quantity)
     */
    public static func getIngredientNameAndQuantity(searchText: String) -> (String, String) {
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
    
    /**
    Check that an ingredient name is valid.
    
    - Parameter name: The name to check.
    
    - Returns: True if the name is valid.
    */
    public static func nameIsValid(name: String) -> Bool {
        return !stringContainsNumber(str: name)
    }
    
    /**
     Check that a quantity is valid.
    
     - Parameter name: The quantity to check.
    
     - Returns: True if the name is valid.
    */
    public static func quantityIsValid(quantity: String) -> Bool {
        return stringContainsNumber(str: quantity) && quantity.count <= 6
    }

    /**
     Format a quantity
    
     The quantity must be stripped of spaces
     
     - Parameter quantity: The quantity to format.
    
     - Returns: The formatted quantity.
    */
    public static func formatQuantity(quantity: String) -> String {
        return quantity.replacingOccurrences(of: " ", with: "")
    }
    
    /**
     Format a name
    
     The name must be capitalised.
     
     - Parameter quantity: The name to format.
    
     - Returns: The formatted name.
    */
    public static func formatName(name: String) -> String {
        return name.capitalise()
    }
    
    // MARK: Private Interface
    
    /// Figure out whether a string contains numbers.
    private static func stringContainsNumber(str: String) -> Bool {
        let numberRegEx = ".*[0-9]+.*"
        let testCase = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        return testCase.evaluate(with: str)
    }
    
}

typealias Ingredients = [Ingredient]
