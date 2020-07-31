//
//  ActionButtonGreen.swift
//  Elenco
//
//  Created by James Bernhardt on 31/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct ActionButtonGreen: View {
    
    var title: String
    var action: () -> ()
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            Text(title)
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

struct ActionButtonGreen_Previews: PreviewProvider {
    static var previews: some View {
        ActionButtonGreen(title: "Hello") {
            print("Hello")
        }
    }
}
