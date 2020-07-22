//
//  String.swift
//  Elenco
//
//  Created by James Kenyon on 09/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation

/**
 Extension to the String class.
 
 - Author: James Kenyon
*/

extension String {
    
    // MARK: Public Interface
    
    /**
    Capitalise the first letter of a string.
     
    - Returns: The capitalised string.
     */
    func capitalise() -> String {
        if self.count > 0 {
            return (self.first?.uppercased() ?? "") + self.dropFirst()
        }
        return ""
    }
    
}
