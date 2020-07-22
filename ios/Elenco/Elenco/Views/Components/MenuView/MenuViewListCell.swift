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
        // if the list is the main list then use name rather than id
        if list.name == ElencoDefaults.mainListName {
            return list.name == listHolderDataModel.list.name
        }
        return list.listID == listHolderDataModel.list.listID
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                if isSelected {
                    GeometryReader { geometry in
                        Capsule()
                            .foregroundColor(Color(#colorLiteral(red: 0.1058823529, green: 0.7647058824, blue: 0.662745098, alpha: 1)))
                            .frame(width: geometry.size.width * 2, height: geometry.size.height + 10)
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
            if !isSelected {
                Text(getMenuSubtitle())
                    .font(.custom("HelveticaNeue-Medium", size: 12))
                    .padding(.horizontal, 15).padding(.top, 5).padding(.bottom, -6)
                    .foregroundColor(Color("Dark-Gray"))
            }
        }
        .padding(.bottom, 16)
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
        self.listHolderDataModel.window.displayAlert(title: "Are you sure you want to delete the list: \(list.name)?", message: nil, okTitle: "Ok") { (action) -> (Void) in
            self.menuViewDataModel.deleteList(list: self.list)
        }
        
    }
    
    private func getMenuSubtitle() -> String {
        var count = 0
        if list.name != ElencoDefaults.mainListName {
            count = ElencoListDataModel.shared.getList(listID: list.listID)?.ingredients.count ?? 0
        } else {
            count = IngredientDataModel.shared.ingredients.count
        }
        return count == 1 ? "\(count) item" : "\(count) items"
    }

    // MARK: - ElencoListDisplayable Methods
    
    func userDidReturnOnTextField() {
        updateButtonTapped()
    }
    
    func userDidEditTextField(newValue: String) {}
    
}
