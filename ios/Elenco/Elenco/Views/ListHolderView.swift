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
    @State var menuDragAmount: CGFloat = -UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            VStack {
                MyListHeaderView()
                .padding(.top, UIDevice.deviceHasCurvedScreen() ? 0:-25)

                if listHolderModel.list.ingredients.count != 0 {
                    ActionView()
                        .padding(.top, 15)
                    
                    Spacer()
                        
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
                }
                else {
                    EmptyListView()
                    .padding(.top)
                }
            }
            .edgesIgnoringSafeArea(.top)
            .onTapGesture {
                self.listHolderModel.menuIsShown = false
            }

            GeometryReader { geometry in
                MenuView()
                    .offset(x: self.menuViewOffset(geometry: geometry), y: 0)
                    .animation(
                        Animation.spring()
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
        }
    }
    
    private func menuViewOffset(geometry: GeometryProxy) -> CGFloat {
        if !listHolderModel.menuIsShown {
            return self.menuDragAmount
        }
        return self.listHolderModel.menuIsShown ? 0 : -geometry.size.width
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
