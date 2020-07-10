//
//  IngredientStore+CoreDataProperties.swift
//  Elenco
//
//  Created by James Bernhardt on 10/07/2020.
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
    @NSManaged public var completed: Bool
    @NSManaged public var name: String?
    @NSManaged public var quantity: String?
    @NSManaged public var parentListID: UUID?
    @NSManaged public var lists: NSSet?

}

// MARK: Generated accessors for lists
extension IngredientStore {

    @objc(addListsObject:)
    @NSManaged public func addToLists(_ value: ListStore)

    @objc(removeListsObject:)
    @NSManaged public func removeFromLists(_ value: ListStore)

    @objc(addLists:)
    @NSManaged public func addToLists(_ values: NSSet)

    @objc(removeLists:)
    @NSManaged public func removeFromLists(_ values: NSSet)

}
