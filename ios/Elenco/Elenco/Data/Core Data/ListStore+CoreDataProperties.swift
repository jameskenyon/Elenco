//
//  ListStore+CoreDataProperties.swift
//  Elenco
//
//  Created by James Bernhardt on 10/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//
//

import Foundation
import CoreData


extension ListStore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListStore> {
        return NSFetchRequest<ListStore>(entityName: "ListStore")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var isShared: Bool
    @NSManaged public var ingredients: NSSet?

}

// MARK: Generated accessors for ingredients
extension ListStore {

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: IngredientStore)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: IngredientStore)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)

}
