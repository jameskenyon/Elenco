//
//  ContentView.swift
//  Elenco
//
//  Created by James Kenyon on 02/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

/// Holds all of the content for the app.

struct ContentView: View {
        
    @EnvironmentObject var listHolderModel: ListHolderDataModel
    @EnvironmentObject var contentViewDataModel: ContentViewDataModel
    
    var body: some View {
        switch self.contentViewDataModel.currentView {
        case .ListHolder:
            return AnyView(ListHolderView(listHolderModel: _listHolderModel))
        case .Essentials:
            return AnyView(EssentialsView())
        case .Recipes:
            return AnyView(EssentialsView())
        case .Settings:
            return AnyView(EssentialsView())
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
