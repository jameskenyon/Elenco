//
//  ElencoListDataModel.swift
//  Elenco
//
//  Created by James Kenyon on 09/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ElencoListDataModel: ObservableObject {
    
    public static let shared = ElencoListDataModel()

    // MARK: Fetch Methods available to public
    
    // create a new list from scratch
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
    
    // delete a list
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
    
    // update the name of a list
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
    
    // get individual list - nil if list not found
    public func getList(listID: UUID) -> ElencoList? {
        let listStore = getListStore(forID: listID)
        if let listStore = listStore {
            return getListFromStore(listStore: listStore)
        }
        return nil
    }
    
    public func getList(listName: String) -> ElencoList? {
        let listStore = getListStore(forName: listName)
        if let listStore = listStore {
            return getListFromStore(listStore: listStore)
        }
        return nil
    }
    
    // get all the lists that the user has currently
    public func getLists() -> [ElencoList] {
        let request: NSFetchRequest<ListStore> = ListStore.fetchRequest()
        do {
            let listStores = try ElencoDefaults.context.fetch(request)
            return listStores.map({ getListFromStore(listStore: $0) })
        } catch {
            return []
        }
    }
    
    // get a list store object for when the user needs to save
    // the list to memory
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
    
    // get a list store object for when the user needs to save
    // the list to memory
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
    
    // MARK: Private helper methods
    
    // get list from store
    private func getListFromStore(listStore: ListStore) -> ElencoList {
        return ElencoList(listStore: listStore)
    }
    
    // update the list so that all lists have an id
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
    
}
