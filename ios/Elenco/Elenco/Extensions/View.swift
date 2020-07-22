//
//  View.swift
//  Elenco
//
//  Created by James Kenyon on 21/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

/**
Extension to the View class.

- Author: James Kenyon
*/

extension View {
    
    // MARK: Public Interface
    
    /**
     Get Bottom padding required for current device.
     
     # Description
        Different views have different requirements for the amount of padding at the bottom of
        them depending on the device model, using this should return the amount of padding required for each view.
     
     # Example Usage
        For the add ingredient button on the home screen, it is placed slighly down for devices that don't have bottom
        element padding.
     
     - Returns: A float containing the amount of padding required.
     */
    func getBottomElementPadding() -> CGFloat {
        let devicesWithoutBottomPadding = [
            "iPhone X",
            "iPhone XS",
            "iPhone XS Max",
            "iPhone XR",
            "iPhone 11",
            "iPhone 11 Pro",
            "iPhone 11 Pro Max",
        ]
        if devicesWithoutBottomPadding.contains(UIDevice.modelName.replacingOccurrences(of: "Simulator ", with: "")) {
            return 0
        }
        return 20
    }
    
}


