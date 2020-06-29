//
//  SortViewButtonItem.swift
//  Elenco
//
//  Created by James Bernhardt on 29/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct SortViewButtonItem: View {
    
    var title: String
    @State var isSelected: Bool
    
    var body: some View {
        Button(action: {
            self.isSelected = !self.isSelected
        }) {
            Text(self.title)
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
        return isSelected ? Color("Orange") : Color("Dark-Gray")
    }
    
    private func viewBackgroundColor() -> Color {
        return isSelected ? Color("Orange") : Color(.white)
    }
    
    private func viewTitleColor() -> Color {
        return isSelected ? Color(.white) : Color("Dark-Gray")
    }
}
