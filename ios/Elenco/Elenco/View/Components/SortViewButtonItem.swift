//
//  SortViewButtonItem.swift
//  Elenco
//
//  Created by James Bernhardt on 29/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct SortViewButtonItem: View {
    
    @EnvironmentObject var myListModel: MyListData

    @State var type: SortType
    
    var body: some View {
        Button(action: {
            self.myListModel.sortType = self.type
        }) {
            Text(self.type.rawValue)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .border(borderColor(), width: 3)
                .font(.system(size: 20))
                .foregroundColor(viewTitleColor())
                .background(viewBackgroundColor())
                .cornerRadius(5)
        }
    }
    
    // Return true if this button has been selected
    private func isSelected() -> Bool {
        return myListModel.sortType == type
    }
    
    // Return border colour
    private func borderColor() -> Color {
        return isSelected() ? Color("Orange") : Color("Dark-Gray")
    }
    
    private func viewBackgroundColor() -> Color {
        return isSelected() ? Color("Orange") : Color(.white)
    }
    
    private func viewTitleColor() -> Color {
        return isSelected() ? Color(.white) : Color("Dark-Gray")
    }
}
