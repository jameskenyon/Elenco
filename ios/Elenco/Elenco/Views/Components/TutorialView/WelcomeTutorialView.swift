//
//  WelcomeTutorialView.swift
//  Elenco
//
//  Created by James Kenyon on 21/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct WelcomeTutorialView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView(.vertical) {
            VStack() {
                Text("Your list is empty at the moment.")
                    .padding()
                    .font(.custom("HelveticaNeue-Bold", size: 22))
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                
                Text("To get started, add a new ingredient to your '\(ElencoDefaults.mainListName)' list by tapping on the ➕ button below.")
                    .padding()
                    .font(.custom("HelveticaNeue-Regular", size: 22))
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.leading)
                
                Text("The '\(ElencoDefaults.mainListName)' list contains the items across all your lists. You can edit or create individual lists by using the menu button at the top left of the screen.")
                    .padding()
                    .font(.custom("HelveticaNeue-Regular", size: 22))
                    .frame(maxWidth: .infinity)
                
                Text("Explore Elenco yourself or swipe left for tips to make the most out of your experience.")
                    .padding()
                    .font(.custom("HelveticaNeue-Regular", size: 22))
                    .frame(maxWidth: .infinity)
                
                Text("Thank you for using Elenco ❤️")
                    .padding()
                    .font(.custom("HelveticaNeue-Regular", size: 22))
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                
//                Text("We believe that your data should stay private. That's why we will never ask you to create an account, or use your                      data for any other purpose than giving you the best experience possible")
//                    .padding().padding(.horizontal, 30)
//                    .font(.custom("HelveticaNeue-Regular", size: 22))
//                    .fixedSize(horizontal: false, vertical: true)
            }
            .foregroundColor(Color("BodyText"))
            .padding(.horizontal, UIDevice.deviceIsIPad() ? 30 : 5)
        }
        .background(Color.clear)
    }

}

#if DEBUG
struct WelcomeTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeTutorialView().environment(\.colorScheme, .dark)
    }
}
#endif
