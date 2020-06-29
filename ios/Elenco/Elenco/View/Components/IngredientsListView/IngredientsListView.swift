//
//  IngredientsListView.swift
//  Elenco
//
//  Created by James Bernhardt on 29/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct IngredientsListView: View {
    
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    
    let ingredients = [
        Ingredient.init(name: "Apple", id: 69, aisle: ""),
        Ingredient.init(name: "Peach", id: 420, aisle: ""),
        Ingredient.init(name: "Chicken", id: 42060, aisle: ""),
        Ingredient.init(name: "Freds", id: 69420, aisle: ""),
    ]
    
    var body: some View {
        List(ingredients, id: \.id) { ingredient in
            IngredientListCell(ingredient: ingredient)
        }
    }
    
}

struct IngredientsListView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsListView()
    }
}
