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
    @EnvironmentObject var contentViewDataModel: ContentViewDataModel
    @State var menuDragAmount: CGFloat = -UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            VStack {
                MyListHeaderView()
                .padding(.top, UIDevice.deviceHasCurvedScreen() ? 0:-25)

                if listHolderModel.list.ingredients.count != 0 {
                    ActionView()
                        .padding(.top, 20)
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
                    .padding(.horizontal).padding(.top, 15)
                    .onTapGesture {
                        self.listHolderModel.userFinishedAddingIngredients()
                    }

                    ZStack {
                        IngredientsListView()
                            .padding(.top, 10)
                        VStack {
                        
                            Spacer()
                            AddIngredientButton()
                                .padding(.bottom, getBottomElementPadding())
                        }
                    }
                }
                else {
                    VStack {
                        TutorialView()
                            .padding(.top)
                            .padding(.horizontal, 20)
                            .onTapGesture {
                                self.listHolderModel.userFinishedAddingIngredients()
                            }
                        Spacer()
                        AddIngredientButton()
                            .padding(.bottom, getBottomElementPadding())
                    }
                }
            }
            .blur(radius: self.listHolderModel.showTickView ? 4 : 0)
            .edgesIgnoringSafeArea(.top)

            GeometryReader { geometry in

                MenuView().environmentObject(MenuViewDataModel(listHolderModel: self.listHolderModel))
                    .environmentObject(self.listHolderModel)
                    .offset(x: self.menuViewOffsetX(geometry: geometry), y: 0)
                    .animation(
                        Animation.interpolatingSpring(stiffness: 200, damping: 100000)
                        .speed(1)
                    )
                .gesture(
                    DragGesture()
                        .onChanged{ gesutre in
                            self.listHolderModel.menuIsShown = false
                            if gesutre.translation.width <= 0 {
                                self.menuDragAmount = gesutre.translation.width
                            }
                        }
                    .onEnded { _ in
                        self.menuDragAmount = -geometry.size.width
                    }
                )
            }
            // Ingredient added view
            ActionCompleteView()
        }
    }

    private func menuViewOffsetX(geometry: GeometryProxy) -> CGFloat {
        if !listHolderModel.menuIsShown {
            return self.menuDragAmount
        }
        return self.listHolderModel.menuIsShown ? 0 : -geometry.size.width
    }
}

struct AddIngredientButton: View {
    
    @EnvironmentObject var listHolderModel: ListHolderDataModel
    @Environment(\.colorScheme) var colorScheme

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
        .shadow(color: colorScheme == .dark ? .clear : Color("Light-Gray").opacity(0.4) , radius: 4)
    }
    
}

#if DEBUG
struct MyListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ListHolderView().environmentObject(ListHolderDataModel(initialList: ElencoList(name: "All"), window: UIWindow()))
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
            .previewDisplayName("iPhone SE")
            
            ListHolderView().environmentObject(ListHolderDataModel(initialList: ElencoList(name: "All"), window: UIWindow()))
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            .previewDisplayName("iPhone 11")
            
        }
    }
}
#endif
