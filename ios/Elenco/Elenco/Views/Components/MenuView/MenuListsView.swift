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
        List {
            ForEach(self.menuViewDataModel.lists, id: \.id) { list in
                MenuViewListCell(list: list)
                .onTapGesture {
                    if let displayList = ElencoListDataModel.shared.getList(listID: list.listID) {
                        self.listHolderDataModel.configureViewForList(newList: displayList)
                        self.listHolderDataModel.menuIsShown = false
                    }
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
    
}
