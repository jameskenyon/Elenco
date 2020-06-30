//
//  MyListHeaderView.swift
//  Elenco
//
//  Created by James Kenyon on 30/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct MyListHeaderView: View {
    
    var numItems: Int = 20
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("My List")
                    .padding(.leading, 20).padding(.bottom, -25).padding(.top, 60)
                    .font(.custom("HelveticaNeue-Bold", size: 36))
                    .foregroundColor(Color.white)
                Spacer()
                Text("\(numItems)")
                    .padding(.trailing, -5).padding(.bottom, -25).padding(.top, 60)
                    .font(.custom("HelveticaNeue-Bold", size: 36))
                    .foregroundColor(Color.white)
                Text(numItems == 1 ? "Item":"Items")
                .padding(.trailing, 20).padding(.bottom, -25).padding(.top, 75)
                    .font(.custom("HelveticaNeue-Bold", size: 16))
                    .foregroundColor(Color.white)
            }
            AddIngredientView()
                .padding(.bottom, 10)
        }
        .background(Color("Teal"))
        .cornerRadius(20)
        .shadow(color: Color("Dark-Gray"), radius: 4)
    }
}

#if DEBUG
struct MyListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MyListHeaderView()
    }
}
#endif
