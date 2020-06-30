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
        
        List {
            ForEach(myListModel.getIngredientSections(), id: \.title) { section in
                Section(header:
                    IngredientSectionHeader(title: section.title)
                        .padding(.top, -18)
                ) {
                    ForEach(section.ingredients, id: \.id) { ingredient in
                        IngredientListCell(ingredient: ingredient)
                    }
                }

            }
        }.listStyle(GroupedListStyle())
    }
}

struct IngredientsListView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsListView()
    }
}
