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
                            Text("My Lists")
                                .font(.system(size: 35, weight: .bold, design: .default))
                                .foregroundColor(Color("Tungsten"))

                            // Underline
                            Rectangle()
                                .frame(width: self.getWidth(geometry: geometry) - 80, height: 1)
                                .foregroundColor(Color("Teal"))
                                .padding(.top, -5)

                            // Lists
                            List {
                                ForEach(self.lists, id: \.name) { list in
                                    Text(list.name)
                                        .font(.system(size: 25, weight: .medium))
                                        .foregroundColor(Color("Tungsten"))
                                        .padding(.leading, -15)
                                        .padding(.vertical, 7)
                                }
                                Button(action: {
                                    print("Add item")
                                }, label: {
                                    Text("+ New List")
                                    .font(.system(size: 25, weight: .medium))
                                    .foregroundColor(Color("Orange"))
                                        .padding(.leading, -15)
                                        .padding(.vertical, 7)

                                })
                            }
                            
                            // Back Button
                            HStack {
                                Spacer()
                                
                                Button(action: {
                                    print("Back")
                                }, label: {
                                    Text("Back")
                                    .font(.system(size: 25, weight: .medium))
                                    .foregroundColor(Color("Tungsten"))
                                })
                                    .padding(.trailing, 30)
                            }
                            

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
