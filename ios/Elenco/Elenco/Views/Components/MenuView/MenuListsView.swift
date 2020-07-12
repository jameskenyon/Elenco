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
    
    var lists: [ElencoList]
    @State var newList: ElencoList?

    var body: some View {  
        List {
            ForEach(self.lists, id: \.name) { list in
                MenuViewListCell(list: list, isEditing: self.newList?.name == list.name)
                .animation(nil)
            }
            
            Button(action: {
                self.newList = ElencoList(name: "New List")
                self.listHolderModel.createList(list: self.newList!)
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
