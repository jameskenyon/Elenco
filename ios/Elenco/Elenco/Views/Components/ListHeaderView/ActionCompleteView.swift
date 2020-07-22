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
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
//                    .cornerRadius(self.listHolderModel.showTickView ? 100 : 20)
                    .frame(maxWidth: geometry.size.width * 0.5,  maxHeight: geometry.size.width * 0.5)
                    .foregroundColor( Color("Light-Teal") )
                    .opacity(0.8)
                    .blur(radius: 10)
                    .clipShape(RoundedRectangle(cornerRadius: self.listHolderModel.showTickView ? 100 : 20))
                    .animation(
                        Animation.easeInOut(duration: 0.4)
//                        .delay(1)
//                        .repeatCount(3, autoreverses: true)
                    )
                    
                
                Image(uiImage: #imageLiteral(resourceName: "saveList"))
                    .frame(width: 1, height: 1)
                    .scaleEffect(self.scale)
                    .animation(
                        Animation.spring(response: 0.4, dampingFraction: 0.3, blendDuration: 0.8)
//                        .delay(1)
//                        .repeatCount(3, autoreverses: true)
                    )
            }
            .onTapGesture {
                self.scale += 1
                self.listHolderModel.showTickView = true
            }
        }
        
    }
    
    private func tickHeight() -> CGFloat {
        return self.listHolderModel.showTickView ? 200 : 0
    }
    
    private func secondTickHeight() -> CGFloat {
        return self.listHolderModel.showTickView ? 100 : 0
    }
}

struct ContentView: View {
    let squareWidth = CGFloat(100)
    let squareHeight = CGFloat(100)

    @State private var bigger = false

    var body: some View {
        HStack {
            VStack {
                Color.green
                    .frame(width: bigger ? self.squareWidth * 2 : self.squareWidth)
                    .frame(height: self.squareHeight)
                    .animation(.default)

                Button("Click me!") { self.bigger.toggle() }
            }.border(Color.black)

            Spacer()

        }.border(Color.red)
    }
}

struct ActionCompleteView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView()
        ActionCompleteView()
    }
}
