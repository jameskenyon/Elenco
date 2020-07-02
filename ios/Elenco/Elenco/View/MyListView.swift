//
//  MyListView.swift
//  Elenco
//
//  Created by James Kenyon on 27/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct MyListView: View {
        
    @EnvironmentObject var myListModel: MyListDataModel
    
    var body: some View {
        VStack {
            MyListHeaderView()
            
            Spacer()
            
            if myListModel.ingredients.count != 0 {
                SortView()
                    .padding(.top, 15)
                
                HStack {
                    Text("NAME").padding(.leading)
                    Spacer()
                    Text("QTY").padding(.trailing)
                }
                .font(.custom("HelveticaNeue-Bold", size: 16))
                .foregroundColor(Color("Dark-Gray"))
                .padding(.horizontal).padding(.top, 20)
                
                IngredientsListView()
                    .padding(.top, 10)
            } else {
                EmptyListView()
                    .padding(.top)
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

#if DEBUG
struct MyListView_Previews: PreviewProvider {
    static var previews: some View {
        MyListView().environmentObject(MyListDataModel(window: UIWindow()))
    }
}
#endif

