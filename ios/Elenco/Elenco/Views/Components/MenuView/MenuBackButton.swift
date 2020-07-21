//
//  MenuBackButton.swift
//  Elenco
//
//  Created by James Bernhardt on 10/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct MenuBackButton: View {
    
    @EnvironmentObject var listHolderModel: ListHolderDataModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: {
                self.listHolderModel.menuIsShown = false
            }, label: {
                Text("Back")
                .font(.custom("HelveticaNeue-Bold", size: 22))
                    .foregroundColor(self.colorScheme == .dark ? Color.white : Color("Tungsten"))
            })
                .padding(.trailing, 30)
        }
    }
}
