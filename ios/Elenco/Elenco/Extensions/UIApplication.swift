//
//  UIApplication.swift
//  Elenco
//
//  Created by James Kenyon on 11/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation
import UIKit

/**
 Extension to the UIApplication Class.
 
 - Author: James Kenyon
 */

extension UIApplication {
    
    // MARK: Public Interface
    
    /**
    Make the application resign first responder.
     
    # Description:
     Stops the user editing a text field if they are currently editing.
    */
    public static func resignResponder() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
