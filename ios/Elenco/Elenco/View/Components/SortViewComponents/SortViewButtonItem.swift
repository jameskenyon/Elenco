//
//  SortViewButtonItem.swift
//  Elenco
//
//  Created by James Bernhardt on 29/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct SortViewButtonItem: View {
    
    @State var sortItem: SortItem
    
    var body: some View {
        Button(action: {
            self.sortItem.isSelected = !self.sortItem.isSelected
        }) {
            Text(self.sortItem.type.rawValue)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .border(borderColor(), width: 3)
                .font(.system(size: 20))
                .foregroundColor(viewTitleColor())
                .background(viewBackgroundColor())
                .cornerRadius(5)
        }
    }
    
    // Return border colour
    private func borderColor() -> Color {
        return sortItem.isSelected ? Color("Orange") : Color("Dark-Gray")
    }
    
    private func viewBackgroundColor() -> Color {
        return sortItem.isSelected ? Color("Orange") : Color(.white)
    }
    
    private func viewTitleColor() -> Color {
        return sortItem.isSelected ? Color(.white) : Color("Dark-Gray")
    }
}
