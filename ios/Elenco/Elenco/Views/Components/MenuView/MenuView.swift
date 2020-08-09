//
//  MenuView.swift
//  Elenco
//
//  Created by James Bernhardt on 09/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    
    @EnvironmentObject var menuViewDataModel: MenuViewDataModel
    @EnvironmentObject var listHolderDataModel: ListHolderDataModel
    @EnvironmentObject var contentViewDataModel: ContentViewDataModel
    
    @Environment(\.colorScheme) var colorScheme
    
    init() {
        UITableView.appearance().separatorStyle  = .none
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
            
        GeometryReader { geometry in
            HStack {
                Rectangle()
                .edgesIgnoringSafeArea(.all)
                .frame(width: self.getWidth(geometry: geometry))
                .foregroundColor(self.colorScheme == .dark ? Color("Lead") : Color.white)
                    .shadow(color: self.colorScheme == .dark ? Color("Orange").opacity(0.1) : Color("Dark-Gray").opacity(0.4), radius: 8, x: 5, y: 5)

                .overlay(
                    List {
                        // Title
                        MenuHeaderView(title: "Lists", image: #imageLiteral(resourceName: "menuListIcon"), width: self.getWidth(geometry: geometry), showSeporator: false)
                            .padding(.leading)
                            .padding(.bottom, 10)
                            .onTapGesture {
                                self.contentViewDataModel.updateView(viewType: .ListHolder)
                        }

                        // Lists
                        MenuListsView()
                            .padding(.top, self.listHolderDataModel.list.name == ElencoDefaults.mainListName ? 5 : 0)
                        
                        ElencoButton(title: "+ New List", width: self.buttonWidth(for: geometry.size)) {
                            self.menuViewDataModel.createNewList()
                        }
                        
                        ElencoButton(title: ElencoDefaults.essentialsName, style: .green, width: self.buttonWidth(for: geometry.size)) {
                            if let essentialsList = ElencoListDataModel.shared.getList(listName: ElencoDefaults.essentialsName) {
                                self.listHolderDataModel.configureViewForList(newList: essentialsList)
                                self.contentViewDataModel.updateView(viewType: .ListHolder)
                            }
                        }
                        
                        // Title
                        MenuHeaderView(title: "Recipes", image: #imageLiteral(resourceName: "menuRecipeIcon"), width: self.getWidth(geometry: geometry))
                        .padding(.leading)
                            .padding(.top)
                            .onTapGesture {
                                self.contentViewDataModel.updateView(viewType: .Recipes)
                            }
                        
//                        MenuHeaderView(title: "Settings", image: #imageLiteral(resourceName: "menuSettingsIcon"), width: self.getWidth(geometry: geometry))
//                        .padding(.leading)
//                            .padding(.top)
//                            .onTapGesture {
//                                self.contentViewDataModel.updateView(viewType: .Settings)
//                        }

                        Spacer()
                        HStack {
                            Spacer()
                            Image("backButton")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding(.trailing, -5)
                            // Back Button
                            MenuBackButton()
                        }
                        .padding(.bottom, self.getBottomElementPadding())
                    }
                    .offset(x: 0, y: -self.contentViewDataModel.keyboardHeight)
                    .animation(
                    Animation.interpolatingSpring(stiffness: 200, damping: 100000)
                        .speed(1)
                    )
                    
                    , alignment: .topLeading)
                Spacer()
            }
        }
    }
    
    private func getWidth(geometry: GeometryProxy) -> CGFloat {
        return geometry.size.width - (geometry.size.width / 4)
    }
    
    private func buttonWidth(for size: CGSize) -> CGFloat {
        size.width * 0.57
    }
    
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

