//
//  MenuView.swift
//  Elenco
//
//  Created by James Bernhardt on 09/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .edgesIgnoringSafeArea(.all)
            
            
            GeometryReader{ geometry in
                Rectangle()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: self.getWidth(geometry: geometry), height: geometry.size.height, alignment: .leading)
                    .foregroundColor(Color.white)
                    .padding(.trailing, self.getWidth(geometry: geometry) / 2)

                    
                .overlay(
                    
                    VStack(alignment: .leading) {
                        Text("My Lists")
                            .font(.system(size: 35, weight: .bold, design: .default))
                            .foregroundColor(Color("Tungsten"))
                            .padding(.leading, 20)
                        
                        Rectangle()
                            .size(width: self.getWidth(geometry: geometry) - 80, height: 1)
                            .foregroundColor(Color("Teal"))
                            .padding(.leading, 20)
                            .padding(.top, -5)
                    }
                    , alignment: .top)
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
