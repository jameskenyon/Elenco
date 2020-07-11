//
//  MenuListsView.swift
//  Elenco
//
//  Created by James Bernhardt on 10/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct MenuListsView: View {
    
    @EnvironmentObject var listHolderModel: ElencoListDataModel
    var lists: [ElencoList]
    @State var newList: ElencoList?

    var body: some View {
        List {
            ForEach(self.lists, id: \.id) { list in
                MenuViewListCell(list: list, isEditing: self.newList?.id == list.id)
            }
            
            Button(action: {
                self.newList = ElencoList(name: "New List")
                self.listHolderModel.createList(list: self.newList!) { (error) in
                    if let error = error { print(error.localizedDescription) }
                }
                self.listHolderModel.selectedList = self.newList
            }, label: {
                Text("+ New List")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(Color("Orange"))
                    .padding(.leading, -15)
                    .padding(.vertical, 7)
            })
        }
    }
}
