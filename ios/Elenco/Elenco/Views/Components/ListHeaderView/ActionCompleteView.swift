//
//  ActionCompleteView.swift
//  Elenco
//
//  Created by James Bernhardt on 21/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct ActionCompleteView: View {
    
    @State var tickHeight: CGFloat = 0
    @State var secondTickHeight: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.9)
                .foregroundColor(Color("Light-Gray"))
                .opacity(0.5)
                
                Capsule()
                    .frame(width: 30, height: self.tickHeight)
                    .foregroundColor(Color.white)
                    .rotationEffect(.degrees(45))
                    .animation(.spring())
//                    .scaleEffect(CGSize(width: 40, height: self.tickHeight), anchor: .bottom)
                
                Capsule()
                    .frame(width: 30, height: self.secondTickHeight)
                    .foregroundColor(Color.white)
                    .rotationEffect(.degrees(135))
                    .animation(.spring())
                
            }
            .onTapGesture {
                self.tickHeight += 200
                self.secondTickHeight += 200
            }
            
        }
        
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
        ContentView()
    }
}
