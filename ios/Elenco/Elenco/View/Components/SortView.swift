//
//  SortView.swift
//  Elenco
//
//  Created by James Bernhardt on 27/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI



struct SortView: View {
    @EnvironmentObject var myListModel: MyListData
    
    let sortTypes: [SortType] = [.name, .quantity, .aisle]
    
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
                    ForEach(sortTypes, id: \.self) { type in
                        SortViewButtonItem(type: type)
                    }

                }
            }.padding(.horizontal, 20)
        )
    }
}




struct SortView_Previews: PreviewProvider {
    static var previews: some View {
        SortView()
    }
}


