//
//  MyListView.swift
//  Elenco
//
//  Created by James Kenyon on 27/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct MyListView: View {
        
    var body: some View {
        VStack {
            MyListHeaderView()
            Spacer()
            SortView()
            IngredientsListView()
                .padding(.top, 15)
        }.edgesIgnoringSafeArea(.top)
    }
}

#if DEBUG
struct MyListView_Previews: PreviewProvider {
    static var previews: some View {
        MyListView()
    }
}
#endif

