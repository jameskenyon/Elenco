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

                        // Lists
                        MenuListsView()
                            .padding(.top, self.listHolderDataModel.list.name == ElencoDefaults.mainListName ? 5 : 10)
                        
                        ElencoButton(title: "+ New List", width: self.buttonWidth(for: geometry.size)) {
                            self.menuViewDataModel.createNewList()
                        }
                        
                        ElencoButton(title: "Essentials", style: .green, width: self.buttonWidth(for: geometry.size)) {
                            print("Edit essentials")
                        }
                        
                        // Title
                        MenuHeaderView(title: "Recipes", image: #imageLiteral(resourceName: "menuRecipeIcon"), width: self.getWidth(geometry: geometry))
                        .padding(.leading)
                            .padding(.top)
                            .onTapGesture {
                                self.recipeButtonTapped()
                            }
                        
                        MenuHeaderView(title: "Settings", image: #imageLiteral(resourceName: "menuSettingsIcon"), width: self.getWidth(geometry: geometry))
                        .padding(.leading)
                            .padding(.top)

                        Spacer()
                        // Back Button
                        MenuBackButton()
                        .padding(.leading, 30)
                            .padding(.bottom, self.getBottomElementPadding())
                    }
                    .offset(x: 0, y: -self.listHolderDataModel.keyboardHeight)
                    .animation(
                    Animation.interpolatingSpring(stiffness: 200, damping: 100000)
                        .speed(1)
                    )
                    
                    , alignment: .topLeading)
                Spacer()
            }
        }
    }
    
    private func recipeButtonTapped() {
        print("Show recipe")
    }
    
    private func settingsButtonTapped() {
        print("Show settings")
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

