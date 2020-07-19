//
//  MenuListsView.swift
//  Elenco
//
//  Created by James Bernhardt on 10/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct MenuListsView: View {
    
    @EnvironmentObject var listHolderModel: ListHolderDataModel
    @EnvironmentObject var listDataModel: ElencoListDataModel
    
    var lists: [ElencoList]

    var body: some View {  
        List {
            ForEach(self.lists, id: \.id) { list in
                MenuViewListCell(list: list, isEditing: list.name == ElencoDefaults.newListName)
                .animation(nil)
            }
            
            Button(action: {
                if self.canCreateNewList() {
                    let newList = ElencoList(name: ElencoDefaults.newListName)
                    self.listHolderModel.createList(list: newList)
                } else {
                    print("Alert")
                }
            }, label: {
                Text("+ New List")
                    .font(.system(size: 25, weight: .medium))
                    .foregroundColor(Color("Orange"))
                    .padding(.leading, 25)
                    .padding(.vertical, 7)
            })
        }
    }
    
    // Return true if user has finished renaming previously created list
    private func canCreateNewList() -> Bool {
        return lists.filter({ $0.name == ElencoDefaults.newListName }).count == 0
    }
}
