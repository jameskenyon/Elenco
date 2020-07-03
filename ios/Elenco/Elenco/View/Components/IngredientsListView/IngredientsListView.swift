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
    
    @EnvironmentObject var myListModel: MyListDataModel
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
    }

    var body: some View {
        ZStack {
            List {
                // display list with the headers
                ForEach(getSortedIngredientSections(), id: \.title) { section in
                    Section(header:
                        IngredientSectionHeader(title: section.title)
                            .padding(.top, -18)
                    ) {
                        ForEach(section.ingredients, id: \.id) { ingredient in
                            IngredientListCell(ingredient: ingredient)
                        }
                        .onDelete { (indexSet) in
                            guard let index = indexSet.first else { return }
                            self.removeIngredient(atSection: section, index: index)
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
        }
    
    }
    
    // Return ingredients sorted according to the sort view options
    func getSortedIngredientSections() -> [IngredientSection] {
        switch myListModel.sortType {
        case .name:
            return myListModel.sortIngredients(
                getSectionHeaders: { $0.map({ $0.completed ? "" : $0.name.first?.lowercased() ?? ""}) },
                ingredientInSection: { $0.name.first?.lowercased() ?? "" == $1 && !$0.completed }
            )
        case .aisle:
            return myListModel.sortIngredients(
                getSectionHeaders: { $0.map({ $0.completed ? "" : $0.aisle }) },
                ingredientInSection: { $0.aisle == $1 && !$0.completed }
            )
        case .none:
            return myListModel.sortIngredients(
                getSectionHeaders: { _ in return ["None"] },
                ingredientInSection: { !$0.completed && $1 == "None" })
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
