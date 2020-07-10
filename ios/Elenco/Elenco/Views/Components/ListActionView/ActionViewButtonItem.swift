//
//  ActionViewButtonItem.swift
//  Elenco
//
//  Created by James Kenyon on 10/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

public enum ActionType: String {
    case clearList     = "Clear List"
    case completeAll   = "Complete All"
}

struct ActionViewButtonItem: View {
    
    @EnvironmentObject var listHolderModel: ListHolderDataModel
    @State var actionType: ActionType
    
    var body: some View {
        Button(action: {
            print("Button pressed")
        }) {
            Text("\(actionType.rawValue)")
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .font(.custom("HelveticaNeue-Medium", size: 22))
                .foregroundColor(viewTitleColor())
                .background(viewBackgroundColor())
        }
        .cornerRadius(10)
    }
    
    private func viewBackgroundColor() -> Color {
        return Color("Light-Teal").opacity(0.1)
    }
    
    private func viewTitleColor() -> Color {
        return Color("Teal")
    }
}

#if DEBUG
struct ActionViewButtonItem_Previews: PreviewProvider {
    static var previews: some View {
        ActionViewButtonItem(actionType: .clearList).environmentObject(ListHolderDataModel(window: UIWindow()))
    }
}
#endif
