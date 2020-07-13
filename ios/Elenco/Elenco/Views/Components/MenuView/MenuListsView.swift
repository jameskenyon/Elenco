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
    var newListName: String {
        return "\(lists.last?.name ?? "")\(lists.count)"
    }

    var body: some View {  
        List {
            ForEach(self.lists, id: \.name) { list in
                MenuViewListCell(list: list, isEditing: self.newListName == list.name)
                .animation(nil)
            }
            
            Button(action: {
                let newList = ElencoList(name: self.newListName)
                self.listHolderModel.createList(list: newList)
            }, label: {
                Text("+ New List")
                    .font(.system(size: 25, weight: .medium))
                    .foregroundColor(Color("Orange"))
                    .padding(.leading, 25)
                    .padding(.vertical, 7)
            })
        }
//    .id(UUID())
    }
    
    private func canCreateNewList() -> Bool {
        return listDataModel.getList(listName: newListName) == nil
    }
}
