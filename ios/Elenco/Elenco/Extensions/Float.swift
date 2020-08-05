//
//  Float.swift
//  Elenco
//
//  Created by James Kenyon on 05/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation

extension Float {
    
    /// Remove .0 from the end of a float if there is one pressent.
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
}
