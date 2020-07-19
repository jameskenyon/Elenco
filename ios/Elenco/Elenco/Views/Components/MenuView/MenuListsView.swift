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
//    var newListName: String {
//        return " "
//    }
    @State var newList: ElencoList?

    var body: some View {  
        List {
            ForEach(self.lists, id: \.id) { list in
                MenuViewListCell(list: list, isEditing: list.name == self.newList?.name)
                .animation(nil)
            }
            
            Button(action: {
                self.newList = ElencoList(name: " ")
                self.listHolderModel.createList(list: self.newList!)
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
    
//    private func canCreateNewList() -> Bool {
//        return listDataModel.getList(listName: newListName) == nil
//    }
}
