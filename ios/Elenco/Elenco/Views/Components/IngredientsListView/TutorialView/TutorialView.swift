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
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Rectangle()
                    .frame(width: 300, height: 300)
                    .foregroundColor(.red)
                Rectangle()
                .frame(width: 300, height: 500)
                .foregroundColor(.blue)
            }
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
