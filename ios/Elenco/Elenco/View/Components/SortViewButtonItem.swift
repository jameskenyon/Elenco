//
//  SortViewButtonItem.swift
//  Elenco
//
//  Created by James Bernhardt on 29/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct SortViewButtonItem: View {
    
    @EnvironmentObject var myListModel: MyListDataModel

    @State var type: SortType
    
    var body: some View {
        Button(action: {
            self.myListModel.sortType = self.type
        }) {
            Text(self.type.rawValue)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .font(.custom("HelveticaNeue-Medium", size: 22))
                .foregroundColor(viewTitleColor())
                .background(viewBackgroundColor())
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(borderColor(), lineWidth: 2)
                )
        }
    }
    
    // Return true if this button has been selected
    private func isSelected() -> Bool {
        return myListModel.sortType == type
    }
    
    // Return border colour
    private func borderColor() -> Color {
        return isSelected() ? Color("Orange") : Color("Light-Gray")
    }
    
    private func viewBackgroundColor() -> Color {
        return isSelected() ? Color("Orange") : Color("Background")
    }
    
    private func viewTitleColor() -> Color {
        return isSelected() ? Color(.white) : Color("Light-Gray")
    }
}

#if DEBUG
struct SortViewButtonItem_Previews: PreviewProvider {
    static var previews: some View {
        SortViewButtonItem(type: .aisle).environmentObject(MyListDataModel(window: UIWindow()))
    }
}
#endif
