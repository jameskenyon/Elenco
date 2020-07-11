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
//    @EnvironmentObject var listHolderModel: ListHolderDataModel
    @State var editedName = "New List"
    @State var list: ElencoList
    @State var isEditing: Bool = false
    
    var isSelected: Bool {
        return listModel.selectedList?.id == list.id
    }

    
    var body: some View {
        ZStack {
            
            if isSelected {
                Rectangle()
                .foregroundColor(Color("Light-Teal"))
                HStack {
                    TextField(list.name, text: $editedName, onCommit: {
                        self.saveList()
                    })
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(Font.custom("HelveticaNeue-Medium", size: 22))
                        .accentColor(Color.white)
                        .foregroundColor(Color.white)
                        .padding(.vertical, 7)

                    // Edit button
                    ZStack {
                        Rectangle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color("Light-Teal"))
                        Image(uiImage: isEditing ? #imageLiteral(resourceName: "saveList") : #imageLiteral(resourceName: "editList"))
                        .resizable()
                        .foregroundColor(Color.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                    }
                    .onTapGesture {
                        print("Edit")
                        self.updateButtonTapped()
                    }

                    // Bin button
                    ZStack {
                        Rectangle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color("Light-Teal"))
                        Image(uiImage: #imageLiteral(resourceName: "deleteList"))
                        .resizable()
                        .foregroundColor(Color.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                    }
                    .onTapGesture {
                        print("bin")
                    }
                }
            } else {
                Text(list.name)
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(Color("Tungsten"))
                .padding(.vertical, 7)
                .onTapGesture {
                    self.listModel.selectedList = self.list
                }
            }
        }
        .padding(.leading, -15)

    }
    
    private func updateButtonTapped() {
        if isEditing {
            let newList = ElencoList(name: editedName)
            listModel.deleteList(listName: list.name)
            listModel.createList(list: newList) { (error) in
                if let error = error { print(error) }
            }
        }
        isEditing.toggle()
    }
    
    // Save new list to coredata
    private func saveList() {
        let newList = ElencoList(name: editedName)
        listModel.createList(list: newList) { (error) in
            if let error = error { print(error) }
        }
    }
    
    // Delete list
    private func deleteList() {
        listModel.deleteList(listName: list.name)
    }
    
}
//
//struct MenuViewListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuViewListCell()
//    }
//}
