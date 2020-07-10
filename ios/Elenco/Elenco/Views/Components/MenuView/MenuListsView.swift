//
//  MenuListsView.swift
//  Elenco
//
//  Created by James Bernhardt on 10/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct MenuListsView: View {
    
    let lists: [ElencoList]
    
    var body: some View {
        List {
            ForEach(self.lists, id: \.name) { list in
                Text(list.name)
                    .font(.system(size: 25, weight: .medium))
                    .foregroundColor(Color("Tungsten"))
                    .padding(.leading, -15)
                    .padding(.vertical, 7)
            }
            Button(action: {
                print("Add item")
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
