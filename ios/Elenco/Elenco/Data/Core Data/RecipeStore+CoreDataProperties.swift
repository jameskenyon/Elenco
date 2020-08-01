//
//  RecipeStore+CoreDataProperties.swift
//  Elenco
//
//  Created by James Kenyon on 01/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//
//

import Foundation
import CoreData


extension RecipeStore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeStore> {
        return NSFetchRequest<RecipeStore>(entityName: "RecipeStore")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var recipeID: UUID?
    @NSManaged public var serves: Int16
    @NSManaged public var isShared: Bool
    @NSManaged public var estimatedTime: String?
    @NSManaged public var image: Data?
    @NSManaged public var ingredients: String?
    @NSManaged public var method: String?
    @NSManaged public var dietaryRequirements: String? 

}
