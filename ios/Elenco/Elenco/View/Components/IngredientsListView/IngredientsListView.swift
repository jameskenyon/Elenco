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
            List {
                ForEach(getSortedIngredientSections(), id: \.title) { section in
                    Section(header:
                        IngredientSectionHeader(title: section.title)
                            .padding(.top, -18)
                    ) {
                        ForEach(section.ingredients, id: \.name) { ingredient in
                            IngredientListCell(ingredient: ingredient)
                        }
                    }

                }
            }.listStyle(GroupedListStyle())
            
            Text("Sorry you have no items")
                .foregroundColor(myListModel.ingredients.isEmpty ? Color("Dark-Gray") : .clear)
        }
        
    }
    
    // Return ingredients sorted according to the sort view options
    func getSortedIngredientSections() -> [IngredientSection] {
        switch myListModel.sortType {
        case .name:     return myListModel.ingredientsSortedByName()
        case .quantity: return myListModel.ingredientsSortedByQuantity()
        case .aisle:    return myListModel.ingredientsSortedByAisle()
        }
    }
}

struct IngredientsListView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsListView()
    }
}
