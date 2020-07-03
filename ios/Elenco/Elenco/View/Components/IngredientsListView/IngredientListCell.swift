//
//  IngredientListCell.swift
//  Elenco
//
//  Created by James Bernhardt on 29/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct IngredientListCell: View {
    
    @EnvironmentObject var myListModel: MyListDataModel
    @State var ingredient: Ingredient
    
    var body: some View {
        HStack {
            IngredientListTick(completed: ingredient.completed)
           
            Text((ingredient.name.first?.uppercased() ?? "") + ingredient.name.dropFirst())
                .strikethrough(self.ingredient.completed, color: Color("Dark-Gray"))
                .font(.system(size: 23, weight: .medium, design: .default))
                .padding(.horizontal, 15)
                .foregroundColor(self.ingredient.completed ? Color("Light-Gray") : Color("BodyText"))
           
           Spacer()
           
           Text("\(ingredient.quantity ?? "Other")")
                .foregroundColor(Color("Light-Gray"))
                .padding(.trailing, 15)
       }
        .onTapGesture {
            self.cellTapped()
        }
        
        .listRowBackground(Color("Background"))
    }
    
    /*
        When ingredient is checked off it is removed from core data
        When ingredient is unchecked off save it back to core data
     */
    private func cellTapped() {
        if ingredient.completed {
            self.myListModel.markUncompleteIngredient(ingredient: ingredient)
        } else {
            self.myListModel.markCompletedIngredient(ingredient: ingredient)
        }
    }
}

struct IngredientListCell_Previews: PreviewProvider {
    static var previews: some View {
        IngredientListCell(ingredient: Ingredient(name: "James", aisle: ""))
    }
}
