//
//  ActionCompleteView.swift
//  Elenco
//
//  Created by James Bernhardt on 21/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct ActionCompleteView: View {
    
    @EnvironmentObject var listHolderModel: ListHolderDataModel
    @State var scale: CGFloat = 0
    @State var percentage: CGFloat = 0
    let mass = 0.4
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .frame(maxWidth: geometry.size.width * 0.3,  maxHeight: geometry.size.width * 0.3)
                    .foregroundColor( Color("Teal") )
                    .blur(radius: 2)
                    .animation(
                        Animation.interpolatingSpring(mass: self.mass, stiffness: 100.0,damping: 10, initialVelocity: 0)
                    )
                    
                Image(uiImage: #imageLiteral(resourceName: "saveList"))
                    .frame(width: 1, height: 1)
                    .modifier(
                        ScaleModifier(totalScale: 0.6, percentage: self.listHolderModel.showTickView ? 1 : 0, completion: {
                            withAnimation {
                               self.listHolderModel.showTickView = false
                            }
                            
                        })
                    )
                    .animation(
                        Animation.interpolatingSpring(mass: self.mass, stiffness: 100.0,damping: 10, initialVelocity: 0)
                    )
            }
            .opacity(self.listHolderModel.showTickView ? 1 : 0)
            .animation(
                Animation.interpolatingSpring(mass: self.mass, stiffness: 100.0,damping: 10, initialVelocity: 0)
                    .delay(0.2)
            )
        }
    }
}

struct ScaleModifier: AnimatableModifier {
    
    var totalScale: CGFloat
    var percentage: CGFloat
    var completion: () -> () = {}
    var scale: CGFloat { percentage * totalScale }
    
    func body(content: Content) -> some View {
        content.scaleEffect(scale)
    }
    
    var animatableData: CGFloat {
        get {
            percentage
        } set (percentage) {
            self.percentage = percentage
            checkIfComplete()
        }
    }
    
    func checkIfComplete() {
        if percentage == 1 {
            DispatchQueue.main.async {
                self.completion()
            }
        }
    }
}

struct ActionCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        ActionCompleteView()
    }
}
