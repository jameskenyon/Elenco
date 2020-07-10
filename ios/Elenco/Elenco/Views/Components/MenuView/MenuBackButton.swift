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
    
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: {
                self.listHolderModel.menuIsShown = false
            }, label: {
                Text("Back")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(Color("Tungsten"))
            })
                .padding(.trailing, 30)
        }
    }
}