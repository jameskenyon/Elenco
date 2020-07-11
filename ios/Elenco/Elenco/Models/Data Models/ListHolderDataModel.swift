//
//  MyListData.swift
//  Elenco
//
//  Created by James Kenyon on 30/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation
import UIKit

/*
    
 Hold all the data for the MyListDataView in this class.
 This means that there is only one view for all the subviews to access
 and all the data is in one place.

 */

class ListHolderDataModel: ObservableObject {
    
    @Published private(set) var list: ElencoList {
        didSet {
            configureDataSourceFor(sortType: sortType)
        }
    }
    
    @Published private(set) var listDataSource: [IngredientSection] = []
    
    @Published private(set) var window: UIWindow
    
    @Published public var sortType: SortType = .name
    
    @Published public var menuIsShown = false
    
    private let ingredientsDataModel = IngredientDataModel()
    private let elencoListDataModel  = ElencoListDataModel()
    
    init(window: UIWindow) {
        self.window = window
        self.list = ElencoList(name: ElencoDefaults.mainListName)
        loadDefaultList()
    }
    
    // MARK: Public Interface
    
    // configure view for list
    public func configureViewForList(newList: ElencoList?) {
        guard let newList = newList else { return }
        self.list = newList
    }
    
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
    
    // remove the ingredient from ingredients array and remove from coredata
    public func deleteIngredient(ingredient: Ingredient) {
        list.ingredients.removeAll(where: { $0.ingredientID == ingredient.ingredientID })
        removeFromCoreDataModel(ingredient: ingredient)
    }
    
    // remove the ingredient from the core data model
    private func removeFromCoreDataModel(ingredient: Ingredient) {
        ingredientsDataModel.delete(ingredient: ingredient) { (error) in
            if let error = error { print(error.localizedDescription) }
        }
    }
        
    // update the properties of an ingredient
    public func updateIngredient(ingredient: Ingredient, newName: String? = nil,
                                 newQuantity: String? = nil, newCompleted: Bool? = nil) {
        for i in 0..<list.ingredients.count {
            if ingredient.ingredientID == list.ingredients[i].ingredientID {
                var updateIngredient = list.ingredients.remove(at: i).copy()
                // if nil don't update the ingredient
                updateIngredient.name = newName ?? ingredient.name
                updateIngredient.quantity = newQuantity ?? ingredient.quantity
                updateIngredient.completed = newCompleted ?? ingredient.completed
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
    
    // load the default list when the view loads
    private func loadDefaultList() {
        self.ingredientsDataModel.fetchIngredients { (error) in
            let list = self.elencoListDataModel.getList(listName: ElencoDefaults.mainListName)
            self.configureViewForList(newList: list)
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

// MARK: - List Holder Actions
extension ListHolderDataModel {
    
    public func completeListAction(actionType: ActionType) {
        switch actionType {
        case .clearList     : handleClearList()
        case .completeAll   : handleAllCompletion(shouldComplete: true)
        case .uncompleteAll : handleAllCompletion(shouldComplete: false)
        }
    }
    
    private func handleClearList() {
        self.window.displayAlert(title: "Are you sure you want to delete all ingredients in this list?", message: nil, okTitle: "Ok") { (action) -> (Void) in
            self.clearList()
        }
    }
    
    private func handleAllCompletion(shouldComplete: Bool) {
        changeCompletion(shouldComplete: shouldComplete)
    }
    
    // ------------------------------------
    // Background tasks
    
    // clear the list of all ingredients
    private func clearList() {
        let ingredientsCopy = self.list.ingredients
        for ingredient in ingredientsCopy {
            deleteIngredient(ingredient: ingredient)
        }
    }
    
    // change the value of the completion
    private func changeCompletion(shouldComplete: Bool) {
        for i in 0..<list.ingredients.count {
            var updateIngredient = list.ingredients.remove(at: i).copy()
            updateIngredient.completed = shouldComplete
            list.ingredients.insert(updateIngredient, at: i)
            self.ingredientsDataModel.update(ingredient: list.ingredients[i]) { (error) in
                if let error = error { print(error.localizedDescription) }
            }
        }
    }
    
}
