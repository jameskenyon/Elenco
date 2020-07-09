//
//  String.swift
//  Elenco
//
//  Created by James Kenyon on 09/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation

extension String {
    
    func capitalise() -> String {
        if self.count > 0 {
            return (self.first?.uppercased() ?? "") + self.dropFirst()
        }
        return ""
    }
    
}
