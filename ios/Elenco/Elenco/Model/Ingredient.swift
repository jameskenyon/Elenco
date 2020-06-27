//
//  Ingredient.swift
//  Elenco
//
//  Created by James Kenyon on 27/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation

/*
 
 The Ingredient structure will encapsulate an ingredient in the app.
 It will hold all of the information about an ingredient including:
 its name, the quantity that the user has specified and the aisle
 it would commonly be found down (in the supermarket).

 */

struct Ingredient: Codable {
    let name: String
    let id: Int
    let aisle: String
}

typealias Ingredients = [Ingredient]
