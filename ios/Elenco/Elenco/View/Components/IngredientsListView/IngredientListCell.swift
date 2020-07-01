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
               .font(.system(size: 23, weight: .medium, design: .default))
               .padding(.horizontal, 15)
           
           Spacer()
           
           Text("\(ingredient.quantity ?? "Other")")
           .foregroundColor(Color("Light-Gray"))
               .padding(.trailing, 15)
       }
        .onTapGesture {
            self.myListModel.removeIngredient(ingredient: self.ingredient)
            self.selected.toggle()
        }
    }
    
    private func cellColor() -> Color {        
        return selected ? Color("Orange") : .clear
    }
    
//    private func setCircle() -> Circle {
//        if selected {
//            let circle = Circle()
//                .frame(width: 30, height: 30)
//                .padding(.leading, 10)
//                .fill(cellColor())
//            return circle
//        } else {
//            let circle = Circle()
//                .frame(width: 30, height: 30)
//                .padding(.leading, 10)
//                .stroke(Color("Orange"), lineWidth: 2)
//            return circle
//        }
//    }
    
}

struct IngredientListCell_Previews: PreviewProvider {
    static var previews: some View {
        IngredientListCell(ingredient: Ingredient(name: "James", id: 69, aisle: ""))
    }
}
