//
//  SortView.swift
//  Elenco
//
//  Created by James Bernhardt on 27/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI



struct SortView: View {
    
    let sortItems: [SortItem] = [
        SortItem(type: .name, isSelected: true),
        SortItem(type: .quantity, isSelected: false),
        SortItem(type: .aisle, isSelected: false),
    ]
    
    var body: some View {
        ShadowView(width: 380, height: 140)
        .overlay(
        
            VStack(alignment: .center) {
                HStack {
                    Text("Sort By")
                    .padding(.vertical, 15)
                    .font(.system(size: 30, weight: .bold, design: .default))
                    
                    Spacer()

                    Button(action: {
                        print("hide")
                    }) {
                        Text("Hide")
                        .foregroundColor(Color("Orange"))
                        .font(.system(size: 20))
                    }
                }.padding(.horizontal, 20)
                    .padding(.bottom, 10)

                HStack {
                    ForEach(sortItems, id: \.self) { item in
                        SortViewButtonItem(sortItem: item)
                    }

                }
            }.padding(.horizontal, 20)
        )
    }
    
    // Return the selected option or nil if nothing is selected
    func getSelectedSortType() -> SortType? {
        return sortItems.filter({ $0.isSelected }).first?.type
    }
    
}




struct SortView_Previews: PreviewProvider {
    static var previews: some View {
        SortView()
    }
}


