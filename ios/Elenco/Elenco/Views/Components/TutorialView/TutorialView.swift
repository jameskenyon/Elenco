//
//  TutorialView.swift
//  Elenco
//
//  Created by James Bernhardt on 17/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct TutorialView: View {
    
    @EnvironmentObject var listHolderModel: ListHolderDataModel

    @Environment(\.colorScheme) var colorScheme
    @State var currentPage: Int = 0
    @State var tutorialTitles: [String]
    
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 10)
                .shadow(color: self.colorScheme == .dark ? Color.black : Color("Light-Gray"), radius: 5)
                .foregroundColor(Color("Background"))
                .frame(maxWidth: 500, maxHeight: 700)
                .overlay(
                    VStack(alignment: .center) {
                        Text(self.tutorialTitles[self.currentPage])
                            .font(.system(size: 30, weight: .bold, design: .default))
                            .foregroundColor(self.colorScheme == .dark ? Color.white : Color("Lead"))
                            .padding(.top, 35)
                        
                        Rectangle()
                            .foregroundColor(self.colorScheme == .dark ? Color.white : Color("Lead"))
                            .frame(width: geometry.size.width * 0.2, height: 1)
                        
                        ElencoPagerView(pageCount: self.tutorialTitles.count, currentIndex: self.$currentPage) {
                            WelcomeTutorialView()
                            AddIngredientTutorialView()
                            IngredientPredictionTutorialView()
                        }
                        .clipped()
                    }
                , alignment: .top)
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(tutorialTitles: ["Test"])
    }
}
