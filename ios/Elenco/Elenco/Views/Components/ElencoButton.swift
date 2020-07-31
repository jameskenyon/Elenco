//
//  ActionButton.swift
//  Elenco
//
//  Created by James Bernhardt on 31/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

enum ButtonStyleColor {
    case orange
    case green
}

struct ElencoButton: View {
    
    var title: String
    var style: ButtonStyleColor = .orange
    var width: CGFloat? = nil
    var isSelected: Bool = false
    var action: () -> ()
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            if width == nil {
                Text(self.title)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .font(.custom("HelveticaNeue-Medium", size: 22))
                    .foregroundColor(viewTitleColor())
                    .background(viewBackgroundColor())
            } else {
                Text(self.title)
                    .frame(width: width!)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .font(.custom("HelveticaNeue-Medium", size: 22))
                    .foregroundColor(viewTitleColor())
                    .background(viewBackgroundColor())
            }
            
        }
        .cornerRadius(10)
    }
    
    private func viewBackgroundColor() -> Color {
        if style == .orange {
            return isSelected ? Color("Orange") : Color("Orange").opacity(0.1)
        }
        return Color("Light-Teal").opacity(0.1)
    }
    
    private func viewTitleColor() -> Color {
        if style == .orange {
            return isSelected ? Color(.white) : Color("Orange")
        }
        return Color("Teal")
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ElencoButton(title: "Hello") {
            print("Troll")
        }
    }
}
