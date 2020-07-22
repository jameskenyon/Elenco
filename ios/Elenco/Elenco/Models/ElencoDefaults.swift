//
//  ElencoDefaults.swift
//  Elenco
//
//  Created by James Kenyon on 10/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation
import UIKit

/**
 The Elenco defaults will hold the defaults that can be found accross the app.
 
 - Author: James Kenyon
 */

struct ElencoDefaults {
    
    /// The name of the list that holds all of the user's ingredients.
    public static let mainListName = "All"
 
    /// The app context used for saving things with CoreData.
    public static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
}
