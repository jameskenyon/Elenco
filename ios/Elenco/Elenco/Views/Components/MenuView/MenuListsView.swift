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
//    @EnvironmentObject var listHolderModel: ElencoListDataModel
    var lists: [ElencoList]

    
    var body: some View {
        List {
            ForEach(self.lists, id: \.id) { list in
                MenuViewListCell(list: list)
            }
           
            
//            Button(action: {
//                self.listHolderModel.isMenuEditing = true
//            }, label: {
//                Text("+ New List")
//                .font(.system(size: 25, weight: .medium))
//                .foregroundColor(Color("Orange"))
//                    .padding(.leading, -15)
//                    .padding(.vertical, 7)
//            })
        }
    }
}
