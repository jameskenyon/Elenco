//
//  IngredientListTick.swift
//  Elenco
//
//  Created by James Kenyon on 03/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct IngredientListTick: View {
    
    @State var completed: Bool = false
    
    var body: some View {
        VStack {
            if completed {
                Image("checked")
                   .resizable()
                   .frame(width: 38, height: 38)
                   .padding(.leading, 7)
            } else {
                Circle()
                    .stroke(Color("Orange"), lineWidth: 2)
                    .frame(width: 30, height: 30)
                    .padding(.leading, 10)
                    .overlay(
                        Circle()
                            .fill(cellColor())
                            .frame(width: 30, height: 30)
                            .padding(.leading, 10)
                )
            }
        }
    }
    
    private func cellColor() -> Color {
        return completed ? Color("Orange") : .clear
    }
}

#if DEBUG
struct IngredientListTick_Previews: PreviewProvider {
    static var previews: some View {
        IngredientListTick()
    }
}
#endif

