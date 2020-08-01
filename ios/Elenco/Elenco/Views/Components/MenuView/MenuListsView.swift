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
        VStack(alignment: .leading) {
            ForEach(self.menuViewDataModel.lists, id: \.id) { list in
                MenuViewListCell(list: list)
                .onTapGesture {
                    self.displayList(list: list)
                }
            }
            Button(action: {
                self.menuViewDataModel.createNewList()
            }, label: {
                Text("+ New List")
                    .font(.custom("HelveticaNeue-Bold", size: 20))
                    .foregroundColor(Color("Orange"))
                    .padding(.leading, 15)
                    .padding(.vertical, 10)
            })
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
    
}
