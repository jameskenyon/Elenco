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
    
    var body: some View {  
        List {
            ForEach(self.menuViewDataModel.lists, id: \.id) { list in
                MenuViewListCell(list: list, isEditing: list.name == self.menuViewDataModel.newListName)
                .animation(nil)
            }
            
            Button(action: {
                if self.canCreateNewList() {
                    let newList = ElencoList(name: self.menuViewDataModel.newListName)
                    self.menuViewDataModel.createList(list: newList)
                }
            }, label: {
                Text("+ New List")
                    .font(.custom("HelveticaNeue-Bold", size: 20))
                    .foregroundColor(Color("Orange"))
                    .padding(.leading, 15)
                    .padding(.vertical, 10)
            })
        }
    }
    
    // Return true if user has finished renaming previously created list
    private func canCreateNewList() -> Bool {
        return menuViewDataModel.lists.filter({ $0.name == menuViewDataModel.newListName }).count == 0
    }
}
