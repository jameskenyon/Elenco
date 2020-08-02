//
//  MenuHeaderView.swift
//  Elenco
//
//  Created by James Bernhardt on 10/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct MenuHeaderView: View {
    
    @Environment(\.colorScheme) var colorScheme

    var title: String
    var image: UIImage
    var width: CGFloat
    var showSeporator: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Underline
            if showSeporator {
                Rectangle()
                    .frame(width: width * 0.3, height: 2)
                    .foregroundColor(Color("Light-Gray").opacity(0.5))
            }
            
            HStack(alignment: .center) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                
                Text(title)
                    .font(.custom("HelveticaNeue-Bold", size: 35))
                    .foregroundColor(colorScheme == .dark ? Color.white : Color("Tungsten"))
            }
            .padding(.top, 28)
        }
        
    }
}

struct MenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MenuHeaderView(title: "Recipes", image: #imageLiteral(resourceName: "menuRecipeIcon"), width: 1000)
    }
}
