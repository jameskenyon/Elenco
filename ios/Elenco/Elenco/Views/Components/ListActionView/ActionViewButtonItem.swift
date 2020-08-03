//
//  ActionViewButtonItem.swift
//  Elenco
//
//  Created by James Kenyon on 10/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct ActionViewButtonItem: View {
    
    @EnvironmentObject var listHolderModel: ListHolderDataModel
    @State var actionType: ActionType
    
    var body: some View {
        ElencoButton(title: "\(actionType.rawValue)", style: .green) {
            self.listHolderModel.completeListAction(actionType: self.actionType)
        }
    }
}

#if DEBUG
struct ActionViewButtonItem_Previews: PreviewProvider {
    static var previews: some View {
        ActionViewButtonItem(actionType: .clearList).environmentObject(ListHolderDataModel(initialList: ElencoList(name: "All"), window: UIWindow()))
    }
}
#endif
