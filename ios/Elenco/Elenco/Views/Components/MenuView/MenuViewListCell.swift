//
//  MenuViewListCell.swift
//  Elenco
//
//  Created by James Bernhardt on 10/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct MenuViewListCell: View, ElencoTextFieldDisplayable {
    
    @EnvironmentObject var menuViewDataModel: MenuViewDataModel
    @EnvironmentObject var listHolderDataModel: ListHolderDataModel
    @Environment(\.colorScheme) var colorScheme

    @State var list: ElencoList
    @State var isEditing: Bool = false
    
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
                    if isEditing {
                        ElencoTextField(text: $menuViewDataModel.editedName, isFirstResponder: isEditing, textFieldView: self,
                        font: UIFont(name: "HelveticaNeue-Bold", size: 25), color: UIColor.white)
                            .textFieldStyle(PlainTextFieldStyle())
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
                    } else {
                        Text(list.name != "" ? list.name : "Unnamed")
                        .font(.custom("HelveticaNeue-Bold", size: 25))
                        .foregroundColor(Color.white)
                        .padding(.leading, 15)
                        .padding(.vertical, 10)
                        Spacer()
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
                    self.menuViewDataModel.editedName = self.list.name
                }
            } else {
                GeometryReader { geometry in
                    Text(self.list.name != "" ? self.list.name : "Unnamed")
                    .font(.custom("HelveticaNeue-Medium", size: 25))
                        .foregroundColor(self.colorScheme == .dark ? Color.white : Color("Tungsten"))
                    .padding(.leading, 15)
                    .padding(.vertical, 10)
                    .frame(width: geometry.size.width, alignment: .leading)
                }
                .background(self.colorScheme == .dark ? Color("Lead") : Color.white)
            }
        }
    }
    
    private func updateButtonTapped() {
        if isEditing {
            updateList()
            isEditing = false
        } else {
            isEditing = true
        }
    }
    
    // Save new list to coredata
    private func updateList() {
        if menuViewDataModel.editedName != "" {
            if menuViewDataModel.editedName != ElencoDefaults.mainListName {
                menuViewDataModel.updateList(list: list, newName: menuViewDataModel.editedName)
                self.list.name = menuViewDataModel.editedName
            } else {
                listHolderDataModel.window.displayAlert(title: "Invalid list name.", message: "Can't be empty or \(ElencoDefaults.mainListName). Please try again.", okTitle: "Ok", okHandler: nil)
            }
        }
    }
    
    // Delete list
    private func deleteList() {
        menuViewDataModel.deleteList(list: list)
    }

    // MARK: ElencoListDisplayable Methods
    
    func userDidReturnOnTextField() {
        updateButtonTapped()
    }
    
    func userDidEditTextField(newValue: String) {}
    
}
