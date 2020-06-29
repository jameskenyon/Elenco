//
//  MyListView.swift
//  Elenco
//
//  Created by James Kenyon on 27/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct MyListView: View {
    
    @State var numItems = 20
    
    var body: some View {
        VStack {
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
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct MyListView_Previews: PreviewProvider {
    static var previews: some View {
        MyListView()
    }
}
