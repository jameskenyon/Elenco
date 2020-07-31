//
//  MenuListsView.swift
//  Elenco
//
//  Created by James Bernhardt on 10/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct MenuListsView: View {
    
    @EnvironmentObject var menuViewDataModel: MenuViewDataModel
    @EnvironmentObject var listHolderDataModel: ListHolderDataModel
    
    var body: some View {
        GeometryReader { geometry in
            List {
                ForEach(self.menuViewDataModel.lists, id: \.id) { list in
                    MenuViewListCell(list: list)
                    .onTapGesture {
                        self.displayList(list: list)
                    }
                }
                
                ElencoButton(title: "+ New List", width: self.buttonWidth(for: geometry.size)) {
                    self.menuViewDataModel.createNewList()
                }
                
                ElencoButton(title: "Edit Essentials", style: .green, width: self.buttonWidth(for: geometry.size)) {
                    print("Edit essentials")
                }

            }
        }
    }
    
    private func displayList(list: ElencoList) {
        if let displayList = ElencoListDataModel.shared.getList(listID: list.listID) {
            if displayList.name == ElencoDefaults.mainListName {
                let ingredients = IngredientDataModel.shared.fetchIngredients()
                let mainList = ElencoList(name: ElencoDefaults.mainListName, ingredients: ingredients)
                self.listHolderDataModel.configureViewForList(newList: mainList)
            } else {
                self.listHolderDataModel.configureViewForList(newList: displayList)
            }
            self.listHolderDataModel.menuIsShown = false
        }
    }
    
    // MARK: - View Constants
    private func buttonWidth(for size: CGSize) -> CGFloat {
        size.width * 0.65
    }
    
}
