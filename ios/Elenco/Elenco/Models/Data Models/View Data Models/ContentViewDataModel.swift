//
//  ContentViewDataModel.swift
//  Elenco
//
//  Created by James Kenyon on 02/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation
import UIKit

class ContentViewDataModel: ObservableObject {
    
    /// Updates if the menu should be displayed over this view.
    @Published public var menuIsShown = false
    
    /// Hold the type of the current view that is being displayed
    @Published private(set) var currentView: CurrentViewType = .ListHolder
    
    /// Tracks the keyboard height to make design chanegs accordingly.
    @Published public var keyboardHeight: CGFloat = 0
    
    /// Hide menu and set view using the type
    public func updateView(viewType type: CurrentViewType) {
        self.currentView = type
        self.menuIsShown = false
    }

}

enum CurrentViewType {
    case ListHolder, Recipes, Settings
}
    
