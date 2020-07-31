//
//  SortViewButtonItem.swift
//  Elenco
//
//  Created by James Bernhardt on 29/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct SortViewButtonItem: View {
    
    @EnvironmentObject var listHolderModel: ListHolderDataModel

    @State var type: SortType
    
    var body: some View {
        ElencoButton(title: self.type.rawValue, isSelected: isSelected()) {
            self.listHolderModel.configureDataSourceFor(sortType: self.type)
        }
    }
    
    // Return true if this button has been selected
    private func isSelected() -> Bool {
        return listHolderModel.sortType == type
    }
}

#if DEBUG
struct SortViewButtonItem_Previews: PreviewProvider {
    static var previews: some View {
        SortViewButtonItem(type: .aisle).environmentObject(ListHolderDataModel(initialList: ElencoList(name: "All"), window: UIWindow()))
    }
}
#endif
