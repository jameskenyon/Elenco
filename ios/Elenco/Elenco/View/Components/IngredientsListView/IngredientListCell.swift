//
//  IngredientListCell.swift
//  Elenco
//
//  Created by James Bernhardt on 29/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct IngredientListCell: View {
    
    var ingredient: Ingredient
    
    var body: some View {
        HStack {
           Circle()
               .stroke(Color("Orange"), lineWidth: 2)
               .foregroundColor(.clear)
               .frame(width: 30, height: 30)
               .padding(.leading, 15)
           
            Text((ingredient.name.first?.uppercased() ?? "") + ingredient.name.dropFirst())
               .font(.system(size: 23, weight: .medium, design: .default))
               .padding(.horizontal, 15)
           
           Spacer()
           
           Text("\(ingredient.id)")
           .foregroundColor(Color("Light-Gray"))
               .padding(.trailing, 15)
       }
    }
    
}

struct IngredientListCell_Previews: PreviewProvider {
    static var previews: some View {
        IngredientListCell(ingredient: Ingredient(name: "James", id: 69, aisle: ""))
    }
}
