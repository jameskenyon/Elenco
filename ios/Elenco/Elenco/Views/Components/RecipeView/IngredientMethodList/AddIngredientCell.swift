//
//  AddIngredientCell.swift
//  Elenco
//
//  Created by James Bernhardt on 03/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct AddIngredientCell: View {
    var ingredient: Ingredient
    
    var body: some View {
        HStack {
            Text(ingredient.name)
                .foregroundColor(Color("Lead"))
                .font(.custom("HelveticaNeue-Regular", size: 23))
            
            Spacer()
            
            Text(ingredient.quantity ?? "")
            .foregroundColor(Color("Dark-Gray"))
            .font(.custom("HelveticaNeue-Regular", size: 15))
        }
        .padding(.horizontal)
    }
}
