//
//  MenuViewListCell.swift
//  Elenco
//
//  Created by James Bernhardt on 10/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct MenuViewListCell: View {
    
    @EnvironmentObject var menuViewDataModel: MenuViewDataModel
    @EnvironmentObject var listHolderDataModel: ListHolderDataModel
    @State var editedName = ""
    @State var list: ElencoList
    @State var isEditing: Bool
    
    var isSelected: Bool {
        return list.listID == listHolderDataModel.list.listID
    }
    
    var body: some View {
        ZStack {
            if isSelected {
                GeometryReader { geometry in
                    Capsule()
                        .foregroundColor(Color(#colorLiteral(red: 0.1058823529, green: 0.7647058824, blue: 0.662745098, alpha: 1)))
                        .frame(width: geometry.size.width * 2, height: geometry.size.height)
                        .padding(.trailing, geometry.size.width)
                }
                HStack {
                    TextField(list.name, text: $editedName, onCommit: {
                        self.updateList()
                    })
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.custom("HelveticaNeue-Bold", size: 25))
                        .accentColor(Color.white)
                        .foregroundColor(Color.white)
                        .padding(.leading, 15)
                        .padding(.vertical, 10)
                        .disabled(!isEditing)
                        .onAppear {
                            // Add Observer to detect when keyboard will be shown
                            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (notification) in
                                let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                                // Only set keybaord height when cell will not be moved off screen
                                if self.menuViewDataModel.lists.lastIndex(of: self.list) ?? 0 > 5 {
                                    self.listHolderDataModel.keyboardHeight = keyboardSize?.height ?? 0
                                }
                            }
                            // Add observer to detect when keyboard will hide
                            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (notification) in
                                self.listHolderDataModel.keyboardHeight = 0
                            }
                        }

                    if list.name != ElencoDefaults.mainListName {
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
                            .padding(.trailing, 20)
                        .onTapGesture {
                            self.deleteList()
                        }
                    }
                }
                .onAppear {
                    self.editedName = self.list.name
                }
            } else {
                Text(list.name)
                .font(.custom("HelveticaNeue-Medium", size: 25))
                .foregroundColor(Color("Tungsten"))
                .padding(.leading, 15)
                .padding(.vertical, 10)
                .onTapGesture {
                    self.listHolderDataModel.configureViewForList(newList: self.list)
                }
            }
        }
    }
    
    private func updateButtonTapped() {
        if isEditing {
            updateList()
        }
        isEditing.toggle()
    }
    
    // Save new list to coredata
    private func updateList() {
        menuViewDataModel.updateList(list: list, newName: editedName)
    }
    
    // Delete list
    private func deleteList() {
        menuViewDataModel.deleteList(list: list)
    }
    
}
