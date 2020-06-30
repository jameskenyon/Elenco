//
//  SortType.swift
//  Elenco
//
//  Created by James Bernhardt on 30/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation

struct SortItem: Hashable {
    var type: SortType
    var isSelected: Bool
    
}

enum SortType: String {
    case name     = "Name"
    case aisle    = "Aisle"
    case quantity = "Quantity"
}

