//
//  IngredientListCell.swift
//  Elenco
//
//  Created by James Bernhardt on 29/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct IngredientListCell: View {
    
    @EnvironmentObject var listHolderModel: ListHolderDataModel
    @Environment(\.colorScheme) var colorScheme

    @State var ingredient: Ingredient
    
    var body: some View {
        HStack {
            IngredientListTick(completed: ingredient.completed)
            .onTapGesture {
                self.completeButtonTapped()
            }
           
            VStack(alignment: .leading) {
                Text("\(ingredient.name.capitalise())")
                    .strikethrough(self.ingredient.completed, color: Color("Dark-Gray"))
                    .font(.custom("HelveticaNeue-Medium", size: 23))
                    .padding(.horizontal, 15)
                    .foregroundColor(self.ingredient.completed ? Color("Light-Gray") : Color("BodyText"))
                    .onTapGesture {
                        self.listHolderModel.userFinishedAddingIngredients()
                    }
                    .onLongPressGesture {
                        self.nameLabelLongTapped()
                    }
                
                if listHolderModel.list.name == ElencoDefaults.mainListName {
                    Text("List - \(getParentListName())")
                        .font(.custom("HelveticaNeue-Medium", size: 12))
                        .padding(.horizontal, 15).padding(.bottom, 5).padding(.top, 5)
                        .foregroundColor(Color("Dark-Gray"))
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                self.listHolderModel.userFinishedAddingIngredients()
            }
           
           Spacer()
           
           Text("\(ingredient.quantity ?? "1")")
                .foregroundColor(colorScheme == .dark ? Color("Light-Gray") : Color("Dark-Gray"))
                .padding(.trailing, 15)
                .onTapGesture {
                    self.listHolderModel.userFinishedAddingIngredients()
                    self.quantityLabelTapped()
                }
        }
        .listRowBackground(Color("Background"))
        .contentShape(Rectangle())
        .onTapGesture {
            self.listHolderModel.userFinishedAddingIngredients()
        }
    }
    
    /*
        When ingredient is checked off it is removed from core data
        When ingredient is unchecked off save it back to core data
     */
    private func completeButtonTapped() {
        self.listHolderModel.updateIngredient(ingredient: ingredient, newCompleted: !ingredient.completed)
    }
    
    private func quantityLabelTapped() {
        listHolderModel.window.displayAlertWithTextField(title: "Update Quantity", message: "Must contain a number and be at most 6 characters long.", placeholder: "New quantity") { (newValue) in
            if let newValue = newValue {
                if Ingredient.quantityIsValid(quantity: newValue) {
                    let formattedQuantity = Ingredient.formatQuantity(quantity: newValue)
                    self.listHolderModel.updateIngredient(ingredient: self.ingredient, newQuantity: formattedQuantity)
                } else {
                    self.listHolderModel.window.displayAlert(
                        title: "Invalid Quantity.", message: nil, okTitle: nil, okHandler: nil
                    )
                }
            }
        }
    }
    
    private func nameLabelLongTapped() {
        listHolderModel.window.displayAlertWithTextField(title: "Update Name", message: "Name must not contain numbers.", placeholder: "New name") { (newValue) in
            if let newValue = newValue {
                if Ingredient.nameIsValid(name: newValue) {
                    let formattedName = Ingredient.formatName(name: newValue)
                    self.listHolderModel.updateIngredient(ingredient: self.ingredient, newName: formattedName)
                } else {
                    self.listHolderModel.window.displayAlert(
                        title: "Invalid Name.", message: nil, okTitle: nil, okHandler: nil
                    )
                }
            }
        }
    }
    
    private func getParentListName() -> String {
        if let parentListName = ingredient.parentList?.name {
            if parentListName != "" {
                return parentListName
            }
        }
        return ElencoDefaults.mainListName
    }
    
}

struct IngredientListCell_Previews: PreviewProvider {
    static var previews: some View {
        IngredientListCell(ingredient: Ingredient(ingredientID: UUID(), name: "James", aisle: "", parentList: nil))
    }
}
