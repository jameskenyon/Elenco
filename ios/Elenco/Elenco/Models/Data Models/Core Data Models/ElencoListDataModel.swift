//
//  ElencoListDataModel.swift
//  Elenco
//
//  Created by James Kenyon on 09/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import CoreData

/**
 The ElencoListDataModel class is responsible for fetching and saving all of the user's
 lists with CoreData.
 
 - Author: James Kenyon
*/

class ElencoListDataModel: ObservableObject {
    
    /// The shared instance of ElencoListDataModel
    public static let shared = ElencoListDataModel()

    // MARK: Public Interface
    
    /**
     Create a new list from scratch.
     
     - Parameters:
        - list: The list to create.
        - completion: The completion handler.
     */
    public func createList(list: ElencoList, completion: @escaping (Error?) -> ()) {
        let listStore = ListStore(context: ElencoDefaults.context)
        listStore.id       = list.id
        listStore.listID   = list.listID
        listStore.name     = list.name
        listStore.isShared = list.isSharedList
        listStore.ingredients = []
        do {
            try ElencoDefaults.context.save()
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    /**
     Delete a list.
     
     - Parameter list: The list to delete.
     */
    public func deleteList(list: ElencoList) {
        DispatchQueue.global().async {
            let request: NSFetchRequest<ListStore> = ListStore.fetchRequest()
            request.predicate = NSPredicate(format: "listID == %@", list.listID as CVarArg)
            do {
                guard let listEntity = try ElencoDefaults.context.fetch(request).first else { return }
                ElencoDefaults.context.delete(listEntity)
                try ElencoDefaults.context.save()
            } catch {}
        }
    }
    
    /**
     Update the name of a list.
     
     - Parameters:
        - list: The list to update.
        - newName: The new name to give to the list.
     */
    public func updateListName(list: ElencoList, newName: String) {
        let request: NSFetchRequest<ListStore> = ListStore.fetchRequest()
        request.predicate = NSPredicate(format: "listID == %@", list.listID as CVarArg)
        do {
            guard let listEntity = try ElencoDefaults.context.fetch(request).first else {
                return
            }
            listEntity.setValue(newName, forKey: "name")
            try ElencoDefaults.context.save()
        } catch {} // ignore for now
    }
    
    /**
     Get a list by listID
     
     - Parameter listID: The ID of the list to retreive.
    
     - Returns: The list (nil if no list was found with matching ID)
     */
    public func getList(listID: UUID) -> ElencoList? {
        let listStore = getListStore(forID: listID)
        if let listStore = listStore {
            return getListFromStore(listStore: listStore)
        }
        return nil
    }
    
    /**
     Get a list by name.
     
     - Parameter listName: The name of the list to retreive.
    
     - Returns: The list (nil if no list was found with matching name)
     */
    public func getList(listName: String) -> ElencoList? {
        let listStore = getListStore(forName: listName)
        if let listStore = listStore {
            return getListFromStore(listStore: listStore)
        }
        return nil
    }
    
    /**
     Get all of the user's current lists.
     
     Append the all list to the lists array. This all list contains all of the ingredients that the user has and
     also acts as its own list that the user can add to.
     
     - Returns: An array of all of the user's lists.
     */
    public func getLists() -> [ElencoList] {
        let request: NSFetchRequest<ListStore> = ListStore.fetchRequest()
        do {
            var lists = [ElencoList]()
            var addedMainList = false // prevent adding too all lists
            for store in try ElencoDefaults.context.fetch(request) {
                if let listID = store.listID {
                    let list = getList(listID: listID)
                    if var list = list {
                        if list.name == ElencoDefaults.mainListName && addedMainList == false {
                            list.ingredients = IngredientDataModel.shared.fetchIngredients()
                            addedMainList = true
                            lists.append(list)
                        } else {
                            if list.name != ElencoDefaults.mainListName {
                                lists.append(list)
                            }
                        }
                    }
                }
            }
            return lists
        } catch {
            return []
        }
    }
    
    /**
     Get a list store object.
     
     Get a list store object for when the user needs to save the list to memory.
     
     - Parameter listID: The ID of the list to get the store of.
     */
    public func getListStore(forID listID: UUID) -> ListStore? {
        let request: NSFetchRequest<ListStore> = ListStore.fetchRequest()
        request.predicate = NSPredicate(format: "listID == %@", listID as CVarArg)
        do {
            guard let listEntity = try ElencoDefaults.context.fetch(request).first else { return nil }
            return listEntity
        } catch {
            return nil
        }
    }
    
    /**
     Get a list store object.
     
     Get a list store object for when the user needs to save the list to memory.
     
     - Parameter listName: The name of the list to get the store of.
     */
    public func getListStore(forName listName: String) -> ListStore? {
        let request: NSFetchRequest<ListStore> = ListStore.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", listName)
        do {
            guard let listEntity = try ElencoDefaults.context.fetch(request).first else { return nil }
            return listEntity
        } catch {
            return nil
        }
    }
    
    /// Update lists so that all lists have an ID.
    public func updateListsIfRequired() {
        let request: NSFetchRequest<ListStore> = ListStore.fetchRequest()
        do {
            let listStore = try ElencoDefaults.context.fetch(request)
            for store in listStore {
                if store.listID == nil {
                    store.setValue(UUID(), forKey: "listID")
                }
            }
            try ElencoDefaults.context.save()
        } catch {}
    }
    
    // MARK: Private Interface
    
    // Get list from store
    private func getListFromStore(listStore: ListStore) -> ElencoList {
        return ElencoList(listStore: listStore)
    }
}
