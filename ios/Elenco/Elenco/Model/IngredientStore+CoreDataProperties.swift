//
//  IngredientStore+CoreDataProperties.swift
//  Elenco
//
//  Created by James Bernhardt on 01/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//
//

import Foundation
import CoreData


extension IngredientStore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IngredientStore> {
        return NSFetchRequest<IngredientStore>(entityName: "IngredientStore")
    }

    @NSManaged public var aisle: String?
    @NSManaged public var name: String?
    @NSManaged public var quantity: String?

}

// MARK: - Get Ingredient from ingredient core data object
extension IngredientStore {
    func ingredientFromSelf() -> Ingredient {
        return Ingredient(name: self.name ?? "", id: 0, aisle: self.aisle ?? "", quantity: self.quantity)
    }
}
