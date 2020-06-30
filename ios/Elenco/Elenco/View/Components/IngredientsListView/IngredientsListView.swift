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
    
    
    
//    let ingredientSections: [IngredientSection] = [
//        IngredientSection.init(title: "A", ingredients: [
//            Ingredient.init(name: "Apple", id: 69, aisle: ""),
//            Ingredient.init(name: "Avocado", id: 420, aisle: ""),
//        ]),
//
//        IngredientSection.init(title: "D", ingredients: [
//            Ingredient.init(name: "Dragon Fruit", id: 69420, aisle: ""),
//        ]),
//
//        IngredientSection.init(title: "G", ingredients: [
//            Ingredient.init(name: "Grapes", id: 42069, aisle: ""),
//            Ingredient.init(name: "Ginger", id: 6969, aisle: ""),
//        ]),
//
//    ]
    
    var body: some View {
        
        List {
            ForEach(getIngredientSections(), id: \.title) { section in
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
    
    // Get list of ingredients in alphabetical sections
    func getIngredientSections() -> [IngredientSection] {
        let ingredients = myListModel.ingredients
        var sections = [IngredientSection]()
                
        let sectionHeaders = Set(ingredients.map({ $0.name.first! }))
        
        for header in sectionHeaders {
            let ingredientsInSection = ingredients.filter({ $0.name.first! == header })
            let section = IngredientSection(title: String(header), ingredients: ingredientsInSection)
            sections.append(section)
        }
        
        sections = sections.sorted(by: { $0.title < $1.title })
        return sections
    }
    
}

struct IngredientsListView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsListView()
    }
}
