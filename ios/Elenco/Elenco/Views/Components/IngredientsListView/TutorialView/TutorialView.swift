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
        RoundedRectangle(cornerRadius: 10)
            .overlay(
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        EmptyListView()
                            .frame(width: 300, height: 600)
                        EmptyListView()
                            .frame(width: 300, height: 600)
                    }
                }
            
            )
        .shadow(color: Color("Light-Gray"), radius: 5, x: 5, y: 5)
        .foregroundColor(Color(.white))
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
