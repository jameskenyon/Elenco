//
//  IngredientListCell.swift
//  Elenco
//
//  Created by James Bernhardt on 29/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct IngredientListCell: View {
    
    @EnvironmentObject var myListModel: MyListData
    var ingredient: Ingredient
    @State private var selected = false
    
    var body: some View {
        HStack {
            Circle()
                .stroke(Color("Orange"), lineWidth: 2)
                .frame(width: 30, height: 30)
                .padding(.leading, 10)
                .overlay(
                    Circle()
                        .fill(cellColor())
                        .frame(width: 30, height: 30)
                        .padding(.leading, 10)
            )
           
            Text((ingredient.name.first?.uppercased() ?? "") + ingredient.name.dropFirst())
                .strikethrough(selected, color: Color("Dark-Gray"))
                .font(.system(size: 23, weight: .medium, design: .default))
                .padding(.horizontal, 15)
                .foregroundColor(selected ? Color("Light-Gray") : Color.black)
           
           Spacer()
           
           Text("\(ingredient.quantity ?? "Other")")
                .foregroundColor(Color("Light-Gray"))
                .padding(.trailing, 15)
       }
        .onTapGesture {
            self.toggleSelection()
        }
    }
    
    private func cellColor() -> Color {        
        return selected ? Color("Orange") : .clear
    }
    
    /*
        When ingredient is checked off it is removed from core data
        When ingredient is unchecked off save it back to core data
     */
    private func toggleSelection() {
        self.selected.toggle()
        if self.selected {
            self.myListModel.removeFromCoreDataModel(ingredient: self.ingredient)
        } else {
            self.myListModel.saveIngredient(ingredient: self.ingredient)
        }
    }
}

struct IngredientListCell_Previews: PreviewProvider {
    static var previews: some View {
        IngredientListCell(ingredient: Ingredient(name: "James", id: 0, aisle: ""))
    }
}
