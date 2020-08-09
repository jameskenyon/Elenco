//
//  IngredientsListView.swift
//  Elenco
//
//  Created by James Bernhardt on 29/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct IngredientsListView: View {
    
    @EnvironmentObject var listHolderModel: ListHolderDataModel
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
    }

    var body: some View {
        ZStack {
            List {
                // display list with the headers
                ForEach(listHolderModel.listDataSource, id: \.title) { section in
                    Section(header:
                        ElencoSectionHeader(title: section.title)
                            .padding(.top, -18)
                    ) {
                        ForEach(section.content) { ingredient in
                            IngredientListCell(ingredient: ingredient)
                        }
                        .onDelete { (indexSet) in
                            guard let index = indexSet.first else { return }
                            self.removeIngredient(atSection: section, index: index)
                        }
                    }
                }
                Spacer()
            }
            .listStyle(GroupedListStyle())
        }
    }
    
    // Work out which section and row ingredient is in and remove from list
    func removeIngredient(atSection section: ListViewSection<Ingredient>, index: Int) {
        let sections = self.listHolderModel.listDataSource.filter({ $0.title == section.title}).first
        if let ingredient = sections?.content[index] {
            self.listHolderModel.deleteIngredient(ingredient: ingredient)
        }
    }
}
