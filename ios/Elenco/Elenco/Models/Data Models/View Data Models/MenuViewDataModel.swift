//
//  MenuViewDataModel.swift
//  Elenco
//
//  Created by James Kenyon on 20/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import Foundation
import SwiftUI

/**
The view model for the MenuView.

This view is responsible for holding all of the data for a MenuView.
This includes all of the lists that the user owns. There are also
methods to edit the lists.

- Author: James Kenyon and James Bernhardt
*/

class MenuViewDataModel: ObservableObject {
    
    /// The name that is currently being editted by the user.
    @Published var editedName: String = ""
    
    /// When a new list is being created, this will supply the default.
    private var newListName: String {
        get {
            return "List \(lists.count + 1)"
        }
    }
    
    /// Hold the list holder data model for easy access.
    var listHolderDataModel: ListHolderDataModel
    
    /// All the lists that are being displayed in the menu view.
    @Published public var lists: [ElencoList]
    
    /**
     Create a new MenuViewDataModel
     
     - Parameter listHolderModel: The list holder that is displaying this menu.
     */
    init(listHolderModel: ListHolderDataModel) {
        self.listHolderDataModel = listHolderModel
        self.lists = ElencoListDataModel.shared.getLists()
    }
    
    /// Create a new list based on the saved values.
    public func createNewList() {
        let list = ElencoList(name: newListName)
        self.lists.append(list)
        self.listHolderDataModel.configureViewForList(newList: self.lists.last)
        ElencoListDataModel.shared.createList(list: list) { (error) in
            if let error = error { print(error.localizedDescription )}
        }
    }
    
    /**
     Update a list's name.
     
     Currently there are no other properties apart from the list's name that can be updated.
     
     - Parameters:
        - list: The list to update.
        - newName: The new name of the list.
     */
    public func updateList(list: ElencoList, newName: String) {
        for i in 0..<lists.count {
            if list.listID == lists[i].listID {
                var updatedList = lists.remove(at: i).copy()
                updatedList.name = newName
                
                lists.insert(updatedList, at: i)
                DispatchQueue.global().async {
                    ElencoListDataModel.shared.updateListName(list: list, newName: newName)
                }
                self.listHolderDataModel.configureViewForList(newList: lists[i])
            }
        }
    }
    
    /**
     Remove a list from the app.
     
     - Parameter list: The list to be removed.
     */
    public func deleteList(list: ElencoList) {
        lists.removeAll(where: { $0.name == list.name })
        ElencoListDataModel.shared.deleteList(list: list)
        listHolderDataModel.configureViewForList(newList: lists.first)
    }
    
}
