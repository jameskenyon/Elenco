//
//  MenuViewDataModel.swift
//  Elenco
//
//  Created by James Kenyon on 20/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation
import SwiftUI

class MenuViewDataModel: ObservableObject {
    
    private var newListName: String {
        get {
            return "List \(lists.count + 1)"
        }
    }
    
    var listHolderDataModel: ListHolderDataModel
    
    @Published public var lists: [ElencoList]
    
    init(listHolderModel: ListHolderDataModel) {
        self.listHolderDataModel = listHolderModel
        self.lists = ElencoListDataModel.shared.getLists()
    }
    
    // create New List
    public func createNewList() {
        let list = ElencoList(name: newListName)
        self.lists.append(list)
        self.listHolderDataModel.configureViewForList(newList: self.lists.last)
        ElencoListDataModel.shared.createList(list: list) { (error) in
            if let error = error { print(error.localizedDescription )}
        }
    }
    
    // update a list
    public func updateList(list: ElencoList, newName: String) {
        for i in 0..<lists.count {
            if list.listID == lists[i].listID {
                var updatedList = lists.remove(at: i).copy()
                updatedList.name = newName
                
                lists.insert(updatedList, at: i)
                ElencoListDataModel.shared.updateListName(list: list, newName: newName)
                self.listHolderDataModel.configureViewForList(newList: lists[i])
            }
        }
    }
    
    // delete a list
    public func deleteList(list: ElencoList) {
        lists.removeAll(where: { $0.name == list.name })
        ElencoListDataModel.shared.deleteList(list: list)
        listHolderDataModel.configureViewForList(newList: lists.first)
    }
    
}
