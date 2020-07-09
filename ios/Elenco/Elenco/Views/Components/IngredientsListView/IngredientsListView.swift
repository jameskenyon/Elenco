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
                ForEach(myListModel.listDataSource, id: \.title) { section in
                    Section(header:
                        IngredientSectionHeader(title: section.title)
                            .padding(.top, -18)
                    ) {
                        ForEach(section.ingredients) { ingredient in
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
//            .id(UUID())
        }
    
    }
    
    // Work out which section and row ingredient is in and remove from list
    func removeIngredient(atSection section: IngredientSection, index: Int) {
        let sections = self.myListModel.listDataSource.filter({ $0.title == section.title}).first
        if let ingredient = sections?.ingredients[index] {
            self.myListModel.deleteIngredient(ingredient: ingredient)
        }
    }
    
}

struct IngredientsListView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsListView()
    }
}
