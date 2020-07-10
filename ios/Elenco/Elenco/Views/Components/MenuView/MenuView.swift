//
//  MenuView.swift
//  Elenco
//
//  Created by James Bernhardt on 09/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
    }
    
    let lists: [ElencoList] = [
        ElencoList.init(name: "Dinner", ingredients: []),
        ElencoList.init(name: "Shopping", ingredients: []),
        ElencoList.init(name: "James", ingredients: []),
        ElencoList.init(name: "Christmas", ingredients: []),
    ]
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .edgesIgnoringSafeArea(.all)
        
            GeometryReader { geometry in
                Rectangle()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: self.getWidth(geometry: geometry), height: geometry.size.height)
                    .foregroundColor(Color.white)

                    .overlay(
                        VStack(alignment: .leading) {
                            // Title
                            MenuHeaderView(title: "My Lists", width: self.getWidth(geometry: geometry))

                            // Lists
                            MenuListsView(lists: self.lists)
                            
                            // Back Button
                            MenuBackButton()
                            
                        }
                        .padding(.leading, 30)
                        , alignment: .topLeading)
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
