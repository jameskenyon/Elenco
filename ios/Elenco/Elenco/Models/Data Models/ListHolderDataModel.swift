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

class ListHolderDataModel: ObservableObject {
    
    @Published var list: ElencoList {
        didSet {
            configureDataSourceFor(sortType: sortType)
        }
    }
    
    @Published private(set) var listDataSource: [IngredientSection] = []
    
    @Published private(set) var window: UIWindow
    
    @Published public var sortType: SortType = .name
    
    private let ingredientsDataModel = IngredientDataModel()
    
    init(window: UIWindow) {
        self.window = window
        self.list = ElencoList(name: "All", ingredients: [])
        loadLocalIngredientList()
    }
    
    // MARK: Public Interface
    
    public func addIngredient(ingredient: Ingredient) {
        self.list.ingredients.append(ingredient)
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
        for ingredient in list.ingredients {
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
        list.ingredients.removeAll(where: { $0.name == ingredient.name })
        removeFromCoreDataModel(ingredient: ingredient)
    }
    
    // toggle the completed field of an ingredient
    public func toggleCompletedIngredient(ingredient: Ingredient) {
        for i in 0..<list.ingredients.count {
            if ingredient.name == list.ingredients[i].name {
                var updateIngredient = list.ingredients.remove(at: i).copy()
                updateIngredient.completed.toggle()
                list.ingredients.insert(updateIngredient, at: i)
                self.ingredientsDataModel.update(ingredient: list.ingredients[i]) { (error) in
                    if let error = error { print(error.localizedDescription) }
                }
            }
        }
    }
    
    // configure the current data source
    public func configureDataSourceFor(sortType: SortType) {
        switch sortType {
        case .name:
            listDataSource = sortIngredients(
                getSectionHeaders: { $0.map({ $0.completed ? "" : $0.name.first?.lowercased() ?? ""}) },
                ingredientInSection: { $0.name.first?.lowercased() ?? "" == $1 && !$0.completed }
            )
        case .aisle:
            listDataSource = sortIngredients(
                getSectionHeaders: { $0.map({ $0.completed ? "" : $0.aisle }) },
                ingredientInSection: { $0.aisle == $1 && !$0.completed }
            )
        case .none:
            listDataSource = sortIngredients(
                getSectionHeaders: { _ in return ["None"] },
                ingredientInSection: { !$0.completed && $1 == "None" }
            )
        }
        self.sortType = sortType
    }
    
    // MARK: Private Interface
    
    // update this to get the proper list of ingredients from CoreData
    private func loadLocalIngredientList() {
        self.ingredientsDataModel.fetchIngredients { (error) in
            if let error = error { print(error.localizedDescription) }
            // Filter ingredients list to get list of non completed and completed ingredients
            self.list.ingredients = self.ingredientsDataModel.ingredients
        }
    }
    
}

// MARK: - Sort Ingredient Data
extension ListHolderDataModel {

    /*
     Sort ingredients and return
     Param:
        getSectionHeaders - a closure that determines the section header
                            FOR NAME SORT: $0.map({ $0.name.first?.lowercased() ?? ""})
        ingredientInSection - a closeure that determines if the ingredient is in the section
                            FOR NAME SORT: $0.name.first?.lowercased() ?? "" == header && !$0.completed
     */
    public func sortIngredients(
            getSectionHeaders: (Ingredients)->[String],
            ingredientInSection: (Ingredient, String)->Bool)
            -> [IngredientSection] {
        var sections: [IngredientSection] = []
        var completedIngredients: Ingredients = []
        let sectionHeaders = Set(getSectionHeaders(list.ingredients))
        for header in sectionHeaders {
            if header == "" { continue }
            let ingredientsInSection = list.ingredients.filter({
                if $0.completed { if !completedIngredients.contains($0) { completedIngredients.append($0)} }
                return ingredientInSection($0, header)
            })
            let section = IngredientSection(title: String(header), ingredients: ingredientsInSection)
            sections.append(section)
        }
        sections = sections.sorted(by: { $0.title < $1.title })
        if sections.isEmpty { completedIngredients = getCompletedIngredients() }
        // add completed only if it exists
        return completedIngredients.count == 0 ?
            sections : sections + [IngredientSection(title: "Completed", ingredients: completedIngredients)]
    }
    
    // get completed ingredients
    private func getCompletedIngredients() -> Ingredients {
        var returnIngredients = Ingredients()
        list.ingredients.forEach { (ingredient) in
            if ingredient.completed {
                returnIngredients.append(ingredient)
            }
        }
        return returnIngredients
    }


    /* Return ingredients sorted by quantity
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
    
    // Return int from inside a string - when theres no int return 0
    private func getDigits(fromString string: String) -> Int {
        let stringDigit = string.components(separatedBy: CharacterSet.decimalDigits.inverted).first ?? ""
        return Int(stringDigit) ?? 0
    }
     */

}
