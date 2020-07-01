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

class MyListData: ObservableObject {
    
    @Published private(set) var ingredients: Ingredients
    @Published private(set) var window: UIWindow
    @Published public var sortType: SortType = .name
    private let ingredientsDataModel = IngredientDataModel()
    
    init(window: UIWindow) {
        self.window = window
        self.ingredients = []
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
    
    // MARK: Private Interface
    
    // update this to get the proper list of ingredients from CoreData
    private func loadLocalIngredientList() {
        ingredientsDataModel.fetchIngredients { (error) in
            if let error = error { print(error.localizedDescription) }
            self.ingredients = ingredientsDataModel.ingredients
        }
    }
}

// MARK: - Sort Ingredient Data
extension MyListData {

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
        return sections
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
        return sections
    }

    // Return ingredients sorted by quantity
    public func ingredientsSortedByQuantity() -> [IngredientSection] {
        let sortedIngredients = ingredients.sorted(by: { $0.quantity ?? "" > $1.quantity ?? ""})
        return [IngredientSection(title: "", ingredients: sortedIngredients)]
    }
}
