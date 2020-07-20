//
//  TutorialView.swift
//  Elenco
//
//  Created by James Bernhardt on 17/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct TutorialView: View {
    
    @State var currentPage: Int = 0
    
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
                        
                        PagerView(pageCount: 2, currentIndex: self.$currentPage) {
                            EmptyListView()
                            EmptyListView()
                        }
                    }
                , alignment: .top)
        }
    }
    
    // Return size based on percentage of screen size
    private func size(percent: CGFloat, size: CGFloat) -> CGFloat {
        return size * percent
    }
}

struct PagerView<Content: View>: View {
    let pageCount: Int
    @Binding var currentIndex: Int
    let content: Content
    @GestureState private var translation: CGFloat = 0

    init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack(spacing: 0) {
                    self.content.frame(width: geometry.size.width)
                }
                .frame(width: geometry.size.width, alignment: .leading)
                .offset(x: -CGFloat(self.currentIndex) * geometry.size.width)
                .offset(x: self.translation)
                .animation(.spring())
                .gesture(
                    DragGesture().updating(self.$translation) { value, state, _ in
                        state = value.translation.width
                    }.onEnded { value in
                        let offset = value.translation.width / geometry.size.width
                        let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
                        self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
                    }
                )
                HStack {
                    ForEach(0 ..< self.pageCount) { number in
                        PagerIndicator(isActive: number == self.currentIndex)
                    }
                }
                .padding(.bottom, 10)
            }
        }
    }
}

struct PagerIndicator: View {
    var isActive: Bool
    var size: CGFloat = 20
    
    var body: some View {
        ZStack {
            if isActive {
                Circle()
                    .frame(width: size, height: size)
                    .foregroundColor(Color("Light-Teal"))
            } else {
                Circle()
                    .stroke(Color("Light-Teal"), lineWidth: 2)
                    .frame(width: size, height: size)
            }
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
