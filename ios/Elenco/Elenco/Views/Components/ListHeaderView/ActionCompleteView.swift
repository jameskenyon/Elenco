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
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(maxWidth: geometry.size.width * 0.5,  maxHeight: geometry.size.width * 0.5)
                    .foregroundColor(self.listHolderModel.showTickView ? Color("Light-Gray") : Color.clear)
                .opacity(0.5)
                
                HStack(spacing: 0) {
                    
                    Capsule()
                        .frame(width: 30, height: self.secondTickHeight())
                        .foregroundColor(self.listHolderModel.showTickView ? Color.white : Color.clear)
                        .rotationEffect(.degrees(135))
                        .animation(
                            Animation.spring()
                            .delay(1)
                        )
                        .padding(.top, 70).padding(.trailing, 60)
                    
                    Capsule()
                        .frame(width: 30, height: self.tickHeight())
                        .foregroundColor(Color.white)
                        .rotationEffect(.degrees(45))
                        .animation(
                            Animation.spring()
                            .delay(1)
                        )
                }
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
