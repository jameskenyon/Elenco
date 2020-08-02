//
//  EssentialsView.swift
//  Elenco
//
//  Created by James Kenyon on 02/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct EssentialsView: View {
    
    @EnvironmentObject var contentViewDataModel: ContentViewDataModel
    
    var body: some View {
        Button(action: {
            self.contentViewDataModel.menuIsShown = true
        }) {
            Text("Back")
        }
    }
}

struct EssentialsView_Previews: PreviewProvider {
    static var previews: some View {
        EssentialsView()
    }
}
