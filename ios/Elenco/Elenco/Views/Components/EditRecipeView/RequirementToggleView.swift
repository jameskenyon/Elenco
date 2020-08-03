//
//  RequirementToggleView.swift
//  Elenco
//
//  Created by James Bernhardt on 03/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct RequirmentToggleView: View {
    
    @Binding var dietryToggle: Bool
    var dietryName: String
    
    var body: some View {
        HStack {
            Toggle("", isOn: $dietryToggle)
            .labelsHidden()
            
            Text(dietryName)
                .font(.custom("HelveticaNeue-Bold", size: 30))
                .foregroundColor(dietryToggle ? Color("Lead") : Color("Light-Gray"))
                .animation(.easeIn(duration: 5))
                .padding(.leading)
        }
        .padding(.horizontal, 30)
    }
}
