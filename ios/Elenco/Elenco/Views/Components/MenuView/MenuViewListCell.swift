//
//  MenuViewListCell.swift
//  Elenco
//
//  Created by James Bernhardt on 10/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct MenuViewListCell: View {
    
    @EnvironmentObject var myListModel: ListHolderDataModel
    var list: ElencoList
    @State var isEditing: Bool
    
    var body: some View {
        
        Text(list.name)
            .font(.system(size: 25, weight: .medium))
            .foregroundColor(Color("Tungsten"))
            .padding(.leading, -15)
            .padding(.vertical, 7)
    }
}
