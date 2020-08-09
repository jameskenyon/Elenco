//
//  AddRecipeCell.swift
//  Elenco
//
//  Created by James Bernhardt on 03/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI


struct AddRecipeCell: View {
    
    var recipeMethod: RecipeMethod
    
    var body: some View {
        Text(recipeMethod.instruction)
            .foregroundColor(Color("Lead"))
            .font(.custom("HelveticaNeue-Regular", size: 23))
        .padding(.horizontal)
    }
}
