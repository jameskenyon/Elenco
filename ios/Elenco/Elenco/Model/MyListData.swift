//
//  MyListData.swift
//  Elenco
//
//  Created by James Kenyon on 30/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation
import SwiftUI

/*
    
 Hold all the data for the MyListDataView in this class.
 This means that there is only one view for all the subviews to access
 and all the data is in one place.

 */

class MyListData: ObservableObject {
    
    @Published private(set) var ingredients: Ingredients
    @Published public var sortType: SortType = .name
    private let ingredientsDataModel = IngredientDataModel()
    
    init() {
        self.ingredients = []
        loadLocalIngredientList()
    }
    
    // MARK: Public Interface
    
    public func addIngredient(ingredient: Ingredient) {
        self.ingredients.append(ingredient)
        self.saveIngredient(ingredient: ingredient)
    }
    
    public func removeIngredient(ingredient: Ingredient) {
        self.deleteIngredient(ingredient: ingredient)
    }
    
    // MARK: Private Interface
    
    // ⚠️ update this to get the proper list of ingredients from CoreData
    private func loadLocalIngredientList() {
        ingredientsDataModel.fetchIngredients { (error) in
            if let error = error { print(error.localizedDescription) }
            self.ingredients = ingredientsDataModel.ingredients
        }
    }
    
    // ⚠️ save the ingredient to the core data model
    public func saveIngredient(ingredient: Ingredient) {
        ingredientsDataModel.save(ingredient: ingredient) { (error) in
            if let error = error { print(error.localizedDescription) }
        }
    }
    
    // ⚠️ remove the ingredient from the core data model
    private func deleteIngredient(ingredient: Ingredient) {
        ingredientsDataModel.delete(ingredient: ingredient) { (error) in
            if let error = error { print(error.localizedDescription) }
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
