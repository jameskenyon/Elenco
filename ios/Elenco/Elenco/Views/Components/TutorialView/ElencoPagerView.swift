//
//  ElencoPagerView.swift
//  Elenco
//
//  Created by James Bernhardt on 20/07/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct ElencoPagerView<Content: View>: View {
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
                .animation(.interactiveSpring())
                    
                .gesture(
                    DragGesture()
                        .updating(self.$translation) { value, state, _ in
                        state = value.translation.width
                    }
                    .onEnded { value in
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
                .padding(.bottom, 20)
            }
        }
    }
}

// MARK: - Pager Indicator Circle
struct PagerIndicator: View {
    var isActive: Bool
    var size: CGFloat = 15
    
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
