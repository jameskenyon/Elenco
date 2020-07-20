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
                MenuViewListCell(list: list)
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
