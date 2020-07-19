//
//  TutorialView.swift
//  Elenco
//
//  Created by James Bernhardt on 17/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct TutorialView: View {
    
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 10)
                .shadow(color: Color("Light-Gray"), radius: 5, x: 5, y: 5)
                .foregroundColor(Color(.white))
                
                .overlay(
                    VStack(alignment: .center) {
                        Text("Edit Your Lists")
                            .font(.system(size: 30, weight: .bold, design: .default))
                            .foregroundColor(Color("Lead"))
                            .padding(.top, 50)
                        
                        Rectangle()
                            .foregroundColor(Color("Lead"))
                            .frame(width: geometry.size.width * 0.2, height: 1)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                Rectangle()
                                    .frame(width: 300, height: 400)
                                    .foregroundColor(.red)
                                Rectangle()
                                    .frame(width: 300, height: 400)
                                    .foregroundColor(.red)
    //                            EmptyListView()
    //                            EmptyListView()
                            }
                        }
                        .padding(.top, 50)
                    }
                , alignment: .top)
        }
    }
    
    // Return size based on percentage of screen size
    private func size(percent: CGFloat, size: CGFloat) -> CGFloat {
        return size * percent
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
