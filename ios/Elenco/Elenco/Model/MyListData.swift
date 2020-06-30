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
    @Published public var sortType: SortType = .name
    
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
            Ingredient(name: "carrot", id: 1, aisle: "Veg", quantity: "1kg"),
            Ingredient(name: "butternut Squash", id: 2, aisle: "Veg", quantity: "2kg"),
            Ingredient(name: "salad Leaves", id: 3, aisle: "Veg", quantity: "5"),
            Ingredient(name: "summer Fruits", id: 4, aisle: "Fruit", quantity: "10g"),
            Ingredient(name: "tangerine", id: 5, aisle: "Fruit", quantity: "1"),
            Ingredient(name: "toast", id: 10, aisle: "Cooked", quantity: "10"),
        ]
    }
    
    // ⚠️ save the ingredient to the core data model
    private func saveIngredient(ingredinet: Ingredient) {
        
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
