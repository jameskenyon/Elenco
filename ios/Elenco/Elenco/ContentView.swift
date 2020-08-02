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
    
    @State var menuDragAmount: CGFloat = -UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            // Show different views depeneding on the current state
            if self.contentViewDataModel.currentView == .ListHolder {
                ListHolderView(listHolderModel: _listHolderModel)
            } else if self.contentViewDataModel.currentView == .Essentials {
                EssentialsView()
            } else if self.contentViewDataModel.currentView == .Recipes {
                RecipesListView()
            } else {
                SettingsView()
            }
            
            // Display the menu if required
            GeometryReader { geometry in
                MenuView().environmentObject(MenuViewDataModel(listHolderModel: self.listHolderModel))
                    .environmentObject(self.listHolderModel)
                    .offset(x: self.menuViewOffsetX(geometry: geometry), y: 0)
                    .animation(
                        Animation.interpolatingSpring(stiffness: 200, damping: 100000)
                        .speed(1)
                    )
                .gesture(
                    DragGesture()
                        .onChanged{ gesutre in
                            self.contentViewDataModel.menuIsShown = false
                            if gesutre.translation.width <= 0 {
                                self.menuDragAmount = gesutre.translation.width
                            }
                        }
                    .onEnded { _ in
                        self.menuDragAmount = -geometry.size.width
                    }
                )
            }
        }
    }
    
    private func menuViewOffsetX(geometry: GeometryProxy) -> CGFloat {
        if !contentViewDataModel.menuIsShown {
            return self.menuDragAmount
        }
        return self.contentViewDataModel.menuIsShown ? 0 : -geometry.size.width
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif



