//
//  MyListData.swift
//  Elenco
//
//  Created by James Kenyon on 30/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

/**
 The view model for the ListHolderView.
 
 This view is responsible for holding all of the data for a ListHolderView.
 This means that there is only one view for all the subviews to access and all the data is
 in one place.
 
 - Important: This class is responsible for holding a **single** list.
 
 - Author: James Kenyon and James Bernhardt
 */

class ListHolderDataModel: ObservableObject {
    
    // MARK: Properties
    
    /**
     The current list being displayed in the ListHolderView
     
     When this property is updated, the view should alslo be updated and
     the data source should be configured, which in turn supplies the IngredientListView
     with the data it requires to display the list.
     */
    @Published private(set) var list: ElencoList {
        didSet {
            // make sure not sorting by list on other table
            if list.name != ElencoDefaults.mainListName && sortType == .list {
                configureDataSourceFor(sortType: .name)
            }
            configureDataSourceFor(sortType: sortType)
        }
    }
    
    /// The data that is being displayed in the IngredientListView.
    @Published private(set) var listDataSource: [IngredientSection] = []
    
    /// The current app window.
    @Published private(set) var window: UIWindow
    
    /// The sort type that the user is currently sorting the ingredients by.
    @Published public var sortType: SortType = .name
    
    /// Updates if the menu should be displayed over this view.
    @Published public var menuIsShown = false
    
    /// Tracks the keyboard height to make design chanegs accordingly.
    @Published public var keyboardHeight: CGFloat = 0
        
    /// Indicates if the user is currently searching for an ingredient.
    @Published public var userIsAddingIngredient = false
    
    /// Updates if the tick view should be displayed over this view.
    @Published public var showTickView = false
    
    /**
     Create a new ListHolderDataModel.
     
     - Parameters:
        - initialList: The initial list that should be displayed when the view loads.
        - window: The app window, so that alerts can be shown on top of this view.
     */
    init(initialList: ElencoList, window: UIWindow) {
        self.window = window
        self.list = initialList
        
        configureViewForList(newList: self.list)
    }
    
    // MARK: Public Interface
    
    /**
     Configure the ListHolderView for a new list.
     
     When the user updates the list they want to view, this method
     should be called to update the subviews to display that new list.
     
     - Precondition: The new list must not be nil.
     
     - Parameter newList: The new list to be displayed.
     */
    public func configureViewForList(newList: ElencoList?) {
        guard let newList = newList else { return }
        self.list = newList
    }
    
    /**
     Add an ingredient to the current list.
     
     Allow a user to add an ingredient from the table view into the current list that is
     being displayed. A core data call will be required to enure that the ingredient is saved
     on disk.
     
     - Parameter ingredient: The new ingredient to save.
     */
    public func addIngredient(ingredient: Ingredient) {
        var ingredientCopy = ingredient.copy()
        ingredientCopy.parentList = self.list
        self.list.ingredients.append(ingredientCopy)
        self.saveIngredient(ingredient: ingredientCopy)
    }
    
    /**
     Save the ingredient to the core data model.
        
     - Parameter ingredient: The ingredient to save.
     */
    public func saveIngredient(ingredient: Ingredient) {
        IngredientDataModel.shared.save(ingredient: ingredient) { (error) in
            if let error = error { print(error.localizedDescription) }
        }
    }
    
    /**
     Find out if the user already has an ingredient in their list.
     
     - Parameter name: The name of the ingredient to check.
     
     - Returns: True if the ingredient already exists in the user's list.
     */
    public func userHasIngredient(name: String) -> Bool {
        let ingredientAndQuantity = Ingredient.getIngredientNameAndQuantity(searchText: name)
        for ingredient in list.ingredients {
            if ingredient.name.lowercased() == ingredientAndQuantity.0.lowercased() {
                return true
            }
        }
        return false
    }
    
    /**
     Remove an ingredient from a list.
     
     Remove from the ingredients array and remove from core data.
     
     - Important:
        Removing an ingredient from core data will also remove it from the List in core data
        as they are linked with a relationship.
     
     - Parameter ingredient: The ingredient to delete.
     */
    public func deleteIngredient(ingredient: Ingredient) {
        list.ingredients.removeAll(where: { $0.ingredientID == ingredient.ingredientID })
        removeFromCoreDataModel(ingredient: ingredient)
    }
        
    /**
     Update the properties of an ingredinet.
     
     - Important: Provide nil as an argument to any optional property that you don't want to update.
     
     - Parameters:
        - ingredient: The ingredient to update.
        - newName: The new name of the ingredient (if not nill).
        - newQuantity: The new quantity of the ingredient.
        - newCompleted: Whether the updated ingredient has been completed.
     */
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
                IngredientDataModel.shared.update(ingredient: list.ingredients[i]) { (error) in
                    if let error = error { print(error.localizedDescription) }
                }
            }
        }
    }
    
    /**
     Configure the current data source based on a given sort type.
     
     The method does not return a value because it updates the local copy of the ingredient data store. This can
     then be used to display all of the cells in the table view.
     
     - Parameter sortType: The sort type to sort the data source list by.
     */
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
        case .list:
            listDataSource = sortIngredients(
                getSectionHeaders: {
                    $0.map({$0.parentList?.name ?? ElencoDefaults.mainListName})
                    },
                ingredientInSection: { (ingredient, header) in
                    return header == ingredient.parentList?.name
                }
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
    
    /**
     Remove an ingredient from core data.
     
     - Parameter ingredient: The ingredient to be removed from core data.
     */
    private func removeFromCoreDataModel(ingredient: Ingredient) {
        IngredientDataModel.shared.delete(ingredient: ingredient) { (error) in
            if let error = error { print(error.localizedDescription) }
        }
    }
}

// MARK: - Sort Ingredient Data

extension ListHolderDataModel {

    /**
     Sort Ingredients
     
     A method that sorts the ingredients into an array of ingredient sections. This is what the List view will rely on for displaying items.
     
     - Parameters:
        - getSectionHeaders: A closure that determines the sections headers.
        - ingredientInSection: A closure that determines whether the ingredient is in the section.
     
     - Important: Read documentation before implementing method.
     
     # Get Section Headers Example
        $0 = Ingredient
        ```
        $0.map({ $0.name.first?.lowercased() ?? "" })
        ```
        This creates ingredient headers based on the first letter of the name of the ingredient.
     
     # Ingredient In Section Example
        $0 = Ingredient, $1 = Header String
        ```
        $0.name.first?.lowercased() ?? "" == $1 && !$0.completed
        ```
        This gets ingredients which are not completed and have the same first letter as the header.
     
     - Returns: An array of ingredientSecitons.
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
    
    /// Get an array containing the completed ingredients.
    private func getCompletedIngredients() -> Ingredients {
        var returnIngredients = Ingredients()
        list.ingredients.forEach { (ingredient) in
            if ingredient.completed {
                returnIngredients.append(ingredient)
            }
        }
        return returnIngredients
    }
}

// MARK: - List Holder Actions

extension ListHolderDataModel {
    
    /**
     Carry out a list action based on the action type.
     
     - Parameter actionType: The type of action that should be performed on the list.
     */
    public func completeListAction(actionType: ActionType) {
        switch actionType {
        case .clearList     : handleClearList()
        case .completeAll   : handleAllCompletion(shouldComplete: true)
        case .uncompleteAll : handleAllCompletion(shouldComplete: false)
        }
    }
    
    /// Called to clear the list.
    private func handleClearList() {
        self.window.displayAlert(title: "Are you sure you want to delete all ingredients in this list?", message: nil, okTitle: "Ok") { (action) -> (Void) in
            self.clearList()
        }
    }
    
    /**
     Called to complete, or uncomplete, all of the elements in a list.
     
     - Parameter shouldComplete: True if all the items should be set to completed.
     */
    private func handleAllCompletion(shouldComplete: Bool) {
        changeCompletion(shouldComplete: shouldComplete)
    }
    
    // MARK: Background Tasks
    
    /// Clear the current list of all ingredients.
    private func clearList() {
        let ingredientsCopy = self.list.ingredients
        for ingredient in ingredientsCopy {
            deleteIngredient(ingredient: ingredient)
        }
    }
    
    /// Change the value of the completion for all items in the current list.
    private func changeCompletion(shouldComplete: Bool) {
        for i in 0..<list.ingredients.count {
            var updateIngredient = list.ingredients.remove(at: i).copy()
            updateIngredient.completed = shouldComplete
            list.ingredients.insert(updateIngredient, at: i)
            IngredientDataModel.shared.update(ingredient: list.ingredients[i]) { (error) in
                if let error = error { print(error.localizedDescription) }
            }
        }
    }
}

// MARK: - UI Methods

extension ListHolderDataModel {
    
    /**
     Stop user from editing the add ingredient text field.
     
     Called when the user is done adding ingredients.
     First responder should be cancelled and the state is set.
     */
    public func userFinishedAddingIngredients() {
        withAnimation {
            self.menuIsShown = false
            self.userIsAddingIngredient = false
            UIApplication.resignResponder()
        }
    }
}
