//
//  IngredientData+CoreDataProperties.swift
//  Elenco
//
//  Created by James Bernhardt on 01/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//
//

import Foundation
import CoreData


extension IngredientData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IngredientData> {
        return NSFetchRequest<IngredientData>(entityName: "IngredientData")
    }

    @NSManaged public var name: String?
    @NSManaged public var aisle: String?
    @NSManaged public var quantity: String?

}

// MARK: - Get Ingredient from ingredient core data object
extension IngredientData {
    func ingredientFromSelf() -> Ingredient {
        return Ingredient(name: self.name ?? "", id: 69, aisle: self.aisle ?? "", quantity: self.quantity)
    }
}
