//
//  MyListHeaderView.swift
//  Elenco
//
//  Created by James Kenyon on 30/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

/*
 
 The header view for a my list view component.
 This header will contain the title, number of ingredients present and the
 add ingredient search view.
 
 */

struct MyListHeaderView: View {
    
    @EnvironmentObject var listHolderModel: ListHolderDataModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                MenuIcon()
                    .padding(.leading, 20).padding(.bottom, -25).padding(.top, 60)
                    .onTapGesture {
                        self.listHolderModel.menuIsShown = true
                    }
                                
                Text("\(listHolderModel.list.name)")
                    .padding(.leading, 20).padding(.bottom, -25).padding(.top, 60)
                    .font(.custom("HelveticaNeue-Bold", size: 36))
                    .foregroundColor(Color.white)
                
                Spacer()
                
                Text("\(self.listHolderModel.list.ingredients.count)")
                    .padding(.trailing, -5).padding(.bottom, -25).padding(.top, 60)
                    .font(.custom("HelveticaNeue-Bold", size: 36))
                    .foregroundColor(Color.white)
                
                Text(self.listHolderModel.list.ingredients.count == 1 ? "Item":"Items")
                .padding(.trailing, 20).padding(.bottom, -25).padding(.top, 75)
                    .font(.custom("HelveticaNeue-Bold", size: 16))
                    .foregroundColor(Color.white)
            }
            .onTapGesture {
                self.listHolderModel.userFinishedAddingIngredients()
            }
            
            AddIngredientView()
                .padding(.bottom, 10)
        }
        .background(Color("TealBackground"))
        .cornerRadius(20)
        .shadow(color: colorScheme == .dark ? .clear : Color("Dark-Gray") , radius: 4)
    }
}

struct MyListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MyListHeaderView().environment(\.colorScheme, .light)
    }
}
