//
//  MenuViewListCell.swift
//  Elenco
//
//  Created by James Bernhardt on 10/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct MenuViewListCell: View {
    
    @EnvironmentObject var listModel: ElencoListDataModel
    @EnvironmentObject var listHolderModel: ListHolderDataModel
    @State var editedName = ""
    @State var list: ElencoList
    @State var isEditing: Bool
    
    var isSelected: Bool {
        if list.name == ElencoDefaults.newListName {
            return true
        }
        if userDidNotProvideValidName() {
            return false
        }
        return listHolderModel.list.name == list.name
    }
    
    var body: some View {
        ZStack {
            if isSelected {
                GeometryReader { geometry in
                    Capsule()
                        .foregroundColor(Color(#colorLiteral(red: 0.368627451, green: 0.7883469462, blue: 0.6629261374, alpha: 1)))
                        .frame(width: geometry.size.width * 2, height: geometry.size.height)
                        .padding(.trailing, geometry.size.width)
                }
                HStack {
                    TextField(list.name, text: $editedName, onCommit: {
                        self.updateList()
                    })
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.system(size: 25, weight: .bold))
                        .accentColor(Color.white)
                        .foregroundColor(Color.white)
                        .padding(.leading, 25)
                        .padding(.vertical, 10)
                        .disabled(!isEditing)
                        .onAppear {
                            // Add Observer to detect when keyboard will be shown
                            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (notification) in
                                let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                                // Only set keybaord height when cell will not be moved off screen
                                if self.listHolderModel.lists.lastIndex(of: self.list) ?? 0 > 5 {
                                    self.listHolderModel.keyboardHeight = keyboardSize?.height ?? 0
                                }
                            }
                            // Add observer to detect when keyboard will hide
                            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (notification) in
                                self.listHolderModel.keyboardHeight = 0
                            }
                        }

                    // Edit button
                    Image(uiImage: isEditing ? #imageLiteral(resourceName: "saveList") : #imageLiteral(resourceName: "editList"))
                        .resizable()
                        .foregroundColor(Color.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .onTapGesture {
                            self.updateButtonTapped()
                        }

                    // Bin button
                    Image(uiImage: #imageLiteral(resourceName: "deleteList"))
                        .resizable()
                        .foregroundColor(Color.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .padding(.trailing, 10)
                    .onTapGesture {
                        self.deleteList()
                    }
                }
                .onAppear {
                    self.editedName = self.list.name
                }
            } else {
                Text(list.name)
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(Color("Tungsten"))
                .padding(.leading, 25)
                .padding(.vertical, 10)
                .onTapGesture {
                    if !self.userDidNotProvideValidName() {
                        self.listHolderModel.configureViewForList(newList: self.list)
                    }
                }
            }
        }
    }
    
    private func updateButtonTapped() {
        if isEditing {
            if isValidListName() {
                updateList()
            } else {
                isEditing.toggle()
            }
        }
        isEditing.toggle()
    }
    
    // Return true if the edited name is unique
    private func isValidListName() -> Bool {
        return listModel.getList(listName: editedName) == nil
    }
    
    // Save new list to coredata
    private func updateList() {
        listHolderModel.updateList(list: list, newName: editedName)
    }
    
    // Delete list
    private func deleteList() {
        listHolderModel.deleteList(list: list)
    }
    
    // Return if user has not named a new list with valid name
    private func userDidNotProvideValidName() -> Bool {
        return listHolderModel.lists.filter({ $0.name == ElencoDefaults.newListName }).count != 0
    }
}
