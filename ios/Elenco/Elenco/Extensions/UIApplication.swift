//
//  UIApplication.swift
//  Elenco
//
//  Created by James Kenyon on 11/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    public static func resignResponder() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
