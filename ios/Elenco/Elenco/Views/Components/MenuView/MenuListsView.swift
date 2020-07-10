//
//  MenuListsView.swift
//  Elenco
//
//  Created by James Bernhardt on 10/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct MenuListsView: View {
    
    @State var lists: [ElencoList]
    @State var newList: ElencoList?
    
    var body: some View {
        List {
            ForEach(self.lists, id: \.id) { list in
                MenuViewListCell(list: list, isEditing: list.id == self.newList?.id)
            }
            Button(action: {
                print("Add item")
                self.newList = ElencoList(name: "")
                self.lists.append(self.newList!)
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
