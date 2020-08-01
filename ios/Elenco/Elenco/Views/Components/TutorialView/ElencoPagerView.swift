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
    var showsPageIndicator: Bool = true

    init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.content = content()
    }
    
    init(pageCount: Int, currentIndex: Binding<Int>, showsPageIndicator: Bool, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.content = content()
        self.showsPageIndicator = showsPageIndicator
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
                
                if self.showsPageIndicator {
                    HStack {
                        ForEach(0 ..< self.pageCount) { number in
                            PagerIndicator(isActive: number == self.currentIndex)
                                .padding(.top, 10)
                        }
                    }
                    .padding(.bottom, 25)
                }
            }
        }
    }
}

// MARK: - Pager Indicator Circle
struct PagerIndicator: View {
    @Environment(\.colorScheme) var colorScheme
    var isActive: Bool
    var size: CGFloat = 15
    
    var body: some View {
        ZStack {
            if isActive {
                Circle()
                    .frame(width: size, height: size)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color("Teal"))
                    .animation(.default)
            } else {
                Circle()
                    .stroke(colorScheme == .dark ? Color.white : Color("Teal"), lineWidth: 2)
                    .frame(width: size, height: size)
                    .animation(.default)
            }
        }
    }
}
