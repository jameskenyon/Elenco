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
    
    var isSelected: Bool {
        return listModel.selectedList?.id == list.id
    }

    
    var body: some View {
        ZStack {
            
            if isSelected {
                Rectangle()
                .foregroundColor(Color("Light-Teal"))
                HStack {
                    TextField("New List", text: $editedName, onCommit: {
                        self.saveList()
                    })
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(Font.custom("HelveticaNeue-Medium", size: 22))
                        .accentColor(Color.white)
                        .foregroundColor(Color.white)
                        .padding(.vertical, 7)

                    
                    Button(action: {
                        self.saveList()
                    }, label: {
                        Image(uiImage: #imageLiteral(resourceName: "saveList"))
                            .resizable()
                            .foregroundColor(Color.white)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                    })
                }
            } else {
                Text(list.name)
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(Color("Tungsten"))
                .padding(.vertical, 7)
            }
        }
        .padding(.leading, -15)
        .onTapGesture {
            self.listModel.selectedList = self.list
        }
    }
    
    // Save new list to coredata
    private func saveList() {
        let newList = ElencoList(name: editedName)
        listModel.createList(list: newList) { (error) in
            if let error = error { print(error) }
        }
    }
    
}
//
//struct MenuViewListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuViewListCell()
//    }
//}
