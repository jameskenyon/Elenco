//
//  IngredientsListView.swift
//  Elenco
//
//  Created by James Bernhardt on 29/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct IngredientSection {
    var title: String
    var ingredients: [Ingredient]
}

struct IngredientsListView: View {
    
    @EnvironmentObject var myListModel: MyListData
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
    }

    var body: some View {
        ZStack {
            if myListModel.sortType == .name || myListModel.sortType == .aisle {
                List {
                    // display list with the headers
                    ForEach(getSortedIngredientSections(), id: \.title) { section in
                        Section(header:
                            IngredientSectionHeader(title: section.title)
                                .padding(.top, -18)
                        ) {
                            ForEach(section.ingredients, id: \.name) { ingredient in
                                IngredientListCell(ingredient: ingredient)
                            }
                            .onDelete { (indexSet) in
                                guard let index = indexSet.first else { return }
                                self.removeIngredient(atSection: section, index: index)
                            }
                        }
                    }
                }.listStyle(GroupedListStyle())
            } else {
                List {
                    // display list without the headers
                    ForEach(myListModel.ingredients, id: \.name) { ingredient in
                        IngredientListCell(ingredient: ingredient)
                    }
                    .onDelete { (indexSet) in
                        guard let index = indexSet.first else { return }
                        self.removeIngredient(index: index)
                    }
                }
            }
        }
    }
    
    // Return ingredients sorted according to the sort view options
    func getSortedIngredientSections() -> [IngredientSection] {
        switch myListModel.sortType {
        case .name:     return myListModel.ingredientsSortedByName()
        case .quantity: return myListModel.ingredientsSortedByQuantity()
        case .aisle:    return myListModel.ingredientsSortedByAisle()
        case .none:     return myListModel.ingredientsSortedByNone()
        }
    }
    
    // Work out which section and row ingredient is in and remove from list
    func removeIngredient(atSection section: IngredientSection, index: Int) {
        let sections = self.getSortedIngredientSections().filter({ $0.title == section.title}).first
        if let ingredient = sections?.ingredients[index] {
            self.myListModel.deleteIngredient(ingredient: ingredient)
        }
    }
    
    // remove ingredient from the list
    func removeIngredient(index: Int) {
        if myListModel.ingredients.count > index {
            self.myListModel.deleteIngredient(ingredient: myListModel.ingredients[index])
        }
    }
    
}

struct IngredientsListView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsListView()
    }
}
