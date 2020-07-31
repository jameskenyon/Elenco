//
//  ActionButton.swift
//  Elenco
//
//  Created by James Bernhardt on 31/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct ActionButtonOrange: View {
    
    var title: String
    var isSelected: Bool = false
    var action: () -> ()
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            Text(self.title)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .font(.custom("HelveticaNeue-Medium", size: 22))
                .foregroundColor(viewTitleColor())
                .background(viewBackgroundColor())
        }
        .cornerRadius(10)
    }
    
    private func viewBackgroundColor() -> Color {
        return isSelected ? Color("Orange") : Color("Orange").opacity(0.1)
    }
    
    private func viewTitleColor() -> Color {
        return isSelected ? Color(.white) : Color("Orange")
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButtonOrange(title: "Hello") {
            print("Troll")
        }
    }
}
