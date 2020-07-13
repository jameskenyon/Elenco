//
//  MenuViewListCell.swift
//  Elenco
//
//  Created by James Bernhardt on 10/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct MenuListCellButton: View {
    
    let image: UIImage
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 30, height: 30)
                .foregroundColor(Color.clear)
            Image(uiImage: image)
            .resizable()
            .foregroundColor(Color.white)
            .aspectRatio(contentMode: .fit)
            .frame(width: 25, height: 25)
        }
    }
}

struct MenuViewListCell: View {
    
    @EnvironmentObject var listModel: ElencoListDataModel
    @EnvironmentObject var listHolderModel: ListHolderDataModel
    @State var editedName = ""
    @State var list: ElencoList
    @State var isEditing: Bool
    
    var isSelected: Bool {
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
               

                    // Edit button
                    MenuListCellButton(image: isEditing ? #imageLiteral(resourceName: "saveList") : #imageLiteral(resourceName: "editList"))
                    .onTapGesture {
                        self.updateButtonTapped()
                    }

                    // Bin button
                    MenuListCellButton(image: #imageLiteral(resourceName: "deleteList"))
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
                    self.listHolderModel.configureViewForList(newList: self.list)
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
        if editedName == list.name {
            return true
        }
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
    
}
