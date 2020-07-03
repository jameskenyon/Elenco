//
//  MyListData.swift
//  Elenco
//
//  Created by James Kenyon on 30/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

/*
    
 Hold all the data for the MyListDataView in this class.
 This means that there is only one view for all the subviews to access
 and all the data is in one place.

 */

class MyListDataModel: ObservableObject {
    
    @Published private(set) var ingredients: Ingredients = []
    @Published private(set) var completedIngredients: Ingredients = []
    
    @Published private(set) var window: UIWindow
    @Published public var sortType: SortType = .name
    private let ingredientsDataModel = IngredientDataModel()
    
    init(window: UIWindow) {
        self.window = window
        loadLocalIngredientList()
    }
    
    // MARK: Public Interface
    
    public func addIngredient(ingredient: Ingredient) {
        self.ingredients.append(ingredient)
        self.saveIngredient(ingredient: ingredient)
    }
    
    // save the ingredient to the core data model
    public func saveIngredient(ingredient: Ingredient) {
        ingredientsDataModel.save(ingredient: ingredient) { (error) in
            if let error = error { print(error.localizedDescription) }
        }
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
    
    // remove the ingredient from the core data model
    public func removeFromCoreDataModel(ingredient: Ingredient) {
        ingredientsDataModel.delete(ingredient: ingredient) { (error) in
            if let error = error { print(error.localizedDescription) }
        }
    }
    
    // remove the ingredient from ingredients array and remove from coredata
    public func deleteIngredient(ingredient: Ingredient) {
        ingredients.removeAll(where: { $0.name == ingredient.name })
        removeFromCoreDataModel(ingredient: ingredient)
    }
    
    // Mark ingredient as completed
    public func markCompletedIngredient(ingredient: Ingredient) {
        ingredients.removeAll(where: { $0.name == ingredient.name })
        var completedIngredient = ingredient.copy()
        completedIngredient.completed = true
        completedIngredients.append(completedIngredient)
        ingredientsDataModel.update(ingredient: completedIngredient) { (error) in
            if let error = error { print(error.localizedDescription) }
        }
    }
    
    // Mark ingredient as not complete
    public func markUncompleteIngredient(ingredient: Ingredient) {
        completedIngredients.removeAll(where: { $0.name == ingredient.name })
        var unCompletedIngredient = ingredient.copy()
        unCompletedIngredient.completed = false
        ingredients.append(unCompletedIngredient)
        ingredientsDataModel.update(ingredient: unCompletedIngredient) { (error) in
            if let error = error { print(error.localizedDescription) }
        }
    }
    
    // MARK: Private Interface
    
    // update this to get the proper list of ingredients from CoreData
    private func loadLocalIngredientList() {
        ingredientsDataModel.fetchIngredients { (error) in
            if let error = error { print(error.localizedDescription) }
            // Filter ingredients list to get list of non completed and completed ingredients
            self.ingredients = ingredientsDataModel.ingredients.filter({ !$0.completed })
            self.completedIngredients = ingredientsDataModel.ingredients.filter({ $0.completed })
        }
    }
}

// MARK: - Sort Ingredient Data
extension MyListDataModel {

    // Return ingredients sorted into alphabetical sections
    public func ingredientsSortedByName() -> [IngredientSection] {
        var sections = [IngredientSection]()
        let sectionHeaders = Set(ingredients.map({ $0.name.first?.lowercased() ?? ""}))

        // Filter ingredients in each section
        for header in sectionHeaders {
            let ingredientsInSection = ingredients.filter({ $0.name.first?.lowercased() ?? "" == header })
            let section = IngredientSection(title: String(header), ingredients: ingredientsInSection)
            sections.append(section)
        }
        sections = sections.sorted(by: { $0.title < $1.title })
        return addCompletedSection(sections: sections)
    }

    // Return ingredients sorted into sections based on their ailse(type) e.g. Veg, Meat
    public func ingredientsSortedByAisle() -> [IngredientSection] {
        var sections = [IngredientSection]()
        let sectionHeaders = Set(ingredients.map({ $0.aisle}))

        // Go through each section
        for header in sectionHeaders {
            let ingredientsInSection = ingredients.filter({ $0.aisle == header })
            let section = IngredientSection(title: String(header), ingredients: ingredientsInSection)
            sections.append(section)
        }

        sections = sections.sorted(by: { $0.title < $1.title })
        return addCompletedSection(sections: sections)
    }

    // Return ingredients sorted by quantity
    public func ingredientsSortedByQuantity() -> [IngredientSection] {
        let sortedIngredients = ingredients.sorted { (ingredientOne, ingredientTwo) -> Bool in
            let ingredientOneDigits = getDigits(fromString: ingredientOne.quantity ?? "")
            let ingredientTwoDigits = getDigits(fromString: ingredientTwo.quantity ?? "")
            if Int(ingredientOne.quantity ?? "") != nil && Int(ingredientTwo.quantity ?? "") == nil {
                return true
            }
            if Int(ingredientOne.quantity ?? "") == nil && Int(ingredientTwo.quantity ?? "") != nil {
                return false
            }
            return ingredientOneDigits > ingredientTwoDigits
        }
        let sections = [IngredientSection(title: "", ingredients: sortedIngredients)]
        return addCompletedSection(sections: sections)
    }
    
    // Return array of unsorted ingredients in a single section
    public func ingredientsSortedByNone() -> [IngredientSection] {
        let sections = [IngredientSection(title: "", ingredients: ingredients)]
        return addCompletedSection(sections: sections)
    }
    
    // Return int from inside a string - when theres no int return 0
    private func getDigits(fromString string: String) -> Int {
        let stringDigit = string.components(separatedBy: CharacterSet.decimalDigits.inverted).first ?? ""
        return Int(stringDigit) ?? 0
    }
    
    // Add section for checked off ingredients
    private func addCompletedSection(sections: [IngredientSection]) -> [IngredientSection] {
        if !completedIngredients.isEmpty {
            let completedSection = IngredientSection(title: "Completed", ingredients: completedIngredients)
            return sections + [completedSection]
        }
        return sections
        
    }
}
