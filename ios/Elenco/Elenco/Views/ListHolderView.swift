//
//  MyListView.swift
//  Elenco
//
//  Created by James Kenyon on 27/06/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

/*
 
 The my list view holds the view for the app in version 1.0.
 This is where all the views come together.
 
 */

struct ListHolderView: View {
        
    @EnvironmentObject var listHolderModel: ListHolderDataModel
    
    var body: some View {
        ZStack {
            VStack {
                MyListHeaderView()
                .padding(.top, UIDevice.deviceHasCurvedScreen() ? 0:-25)

                if listHolderModel.list.ingredients.count != 0 {
                    ActionView()
                        .padding(.top, 15)
                        .onTapGesture {
                            self.listHolderModel.userFinishedAddingIngredients()
                        }
                    
                    Spacer()
                        
                    HStack {
                        Text("NAME").padding(.leading)
                        Spacer()
                        Text("QTY").padding(.trailing)
                    }
                    .font(.custom("HelveticaNeue-Bold", size: 16))
                    .foregroundColor(Color("Dark-Gray"))
                    .padding(.horizontal).padding(.top, 20)
                    .onTapGesture {
                        self.listHolderModel.userFinishedAddingIngredients()
                    }

                    ZStack {
                        IngredientsListView()
                        .padding(.top, 10)
                        .onTapGesture {
                            self.listHolderModel.userFinishedAddingIngredients()
                        }
                        VStack {
                            Spacer()
                            AddIngredientButton()
                        }
                    }
                }
                else {
                    EmptyListView()
                    .padding(.top)
                }
            }
            .edgesIgnoringSafeArea(.top)
            
            if listHolderModel.menuIsShown {
                MenuView()
            }
        }
    }
}

struct AddIngredientButton: View {
    
    @EnvironmentObject var listHolderModel: ListHolderDataModel

    var body: some View {
        Button(action: {
            withAnimation {
                self.listHolderModel.userIsAddingIngredient = true
            }
         }, label: {
            Text("+")
                .font(.custom("HelveticaNeue-Bold", size: 50))
                .foregroundColor(Color.white)
                .padding(.bottom, 10)
        })
        .buttonStyle(OrangeCircleButtonStyle())
    }
}

#if DEBUG
struct MyListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ListHolderView().environmentObject(ListHolderDataModel(window: UIWindow()))
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
            .previewDisplayName("iPhone SE")
            
            ListHolderView().environmentObject(ListHolderDataModel(window: UIWindow()))
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            .previewDisplayName("iPhone 11")
            
        }
    }
}
#endif
