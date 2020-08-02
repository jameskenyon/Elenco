//
//  ContentViewDataModel.swift
//  Elenco
//
//  Created by James Kenyon on 02/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation

class ContentViewDataModel: ObservableObject {
    
    @Published var currentView: CurrentViewType = .ListHolder

}

enum CurrentViewType {
    case ListHolder, Essentials, Recipes, Settings
}
    
