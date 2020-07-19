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
                let newList = ElencoList(name: ElencoDefaults.newListName)
                self.listHolderModel.createList(list: newList)
            }, label: {
                Text("+ New List")
                    .font(.system(size: 25, weight: .medium))
                    .foregroundColor(Color("Orange"))
                    .padding(.leading, 25)
                    .padding(.vertical, 7)
            })
        }
    }
}
