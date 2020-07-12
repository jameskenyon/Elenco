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
    @State var editedName = ""
    @State var list: ElencoList
    @State var isEditing: Bool
    
    var isSelected: Bool {
        return listModel.selectedList?.id == list.id
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
                        self.saveList()
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
                        print("Edit")
//                        self.updateButtonTapped()
                    }

                    // Bin button
                    MenuListCellButton(image: #imageLiteral(resourceName: "deleteList"))
                        .padding(.trailing, 10)
                    .onTapGesture {
                        print("Delete")
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
                    print("Tap")
                    self.listModel.selectedList = self.list
                }
            }
        }
    }
    
    private func updateButtonTapped() {
        if isEditing {
            print("Update list")
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
