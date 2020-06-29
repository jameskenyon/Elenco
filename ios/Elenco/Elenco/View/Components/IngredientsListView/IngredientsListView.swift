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
            
            HStack {
                Circle()
                    .stroke(Color("Orange"), lineWidth: 2)
                    .foregroundColor(.clear)
                    .frame(width: 30, height: 30)
                    .padding(.leading, 20)
                
                Text(ingredient.name)
                    .font(.system(size: 23, weight: .medium, design: .default))
                    .padding(.horizontal, 15)
                
                Spacer()
                
                Text("\(ingredient.id)")
                .foregroundColor(Color("Light-Gray"))
                    .padding(.trailing, 20)
            }
            
        }
    }
    
}

struct IngredientsListView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsListView()
    }
}
