//
//  SettingsView.swift
//  Elenco
//
//  Created by James Kenyon on 02/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct SettingsView: View {

    @EnvironmentObject var contentViewDataModel: ContentViewDataModel
    
    var body: some View {
        Button(action: {
            self.contentViewDataModel.menuIsShown = true
        }) {
            Text("Back")
        }
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
