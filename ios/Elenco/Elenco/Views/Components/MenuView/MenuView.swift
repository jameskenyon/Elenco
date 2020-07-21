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
                    .shadow(color: self.colorScheme == .dark ? Color("Orange").opacity(0.2) : Color("Dark-Gray").opacity(0.4), radius: 8, x: 5, y: 5)

                .overlay(
                    VStack(alignment: .leading) {
                        // Title
                        MenuHeaderView(title: "My Lists", width: self.getWidth(geometry: geometry))
                            .padding(.leading, 30)

                        // Lists
                        MenuListsView()

                        // Back Button
                        MenuBackButton()
                        .padding(.leading, 30)
                            .padding(.bottom, self.getBottomElementPadding())
                    }
                    .offset(x: 0, y: -self.listHolderDataModel.keyboardHeight)
                    .animation(.spring())
                    
                    , alignment: .topLeading)
                Spacer()
            }
        }
    }
    
    private func getWidth(geometry: GeometryProxy) -> CGFloat {
        return geometry.size.width - (geometry.size.width / 3)
    }
    
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
