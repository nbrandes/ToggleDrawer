//
//  ToggleDrawer.swift
//  ToggleDrawer
//
//  Created by Nick Brandes on 1/17/24.
//

import SwiftUI

fileprivate enum Constants {
    static let radius: CGFloat = 16
    static let indicatorHeight: CGFloat = 6
    static let indicatorWidth: CGFloat = 60
    static let snapRatio: CGFloat = 0.25
    static let minHeightRatio: CGFloat = 0.3
}

@available(iOS 16.0, *)
public struct ToggleDrawer<Content1: View, Content2: View>: View {
    @Binding var isOpen: Bool

    let maxHeight: CGFloat
    let minHeight: CGFloat
    let largeView: Content1
    let smallView: Content2
    let shadowColor: Color
    let shadowRadius: CGFloat
    let cornerRadius: CGFloat

    public init(small: CGFloat,
         large: CGFloat,
         isOpen: Binding<Bool>,
         shadowColor: Color = Color(.clear),
         shadowRadius: CGFloat = 5,
         cornerRadius: CGFloat = 30,
         @ViewBuilder largeView: () -> Content1,
         @ViewBuilder smallView: () -> Content2) {
        
        self.minHeight = small
        self.maxHeight = large
        self.largeView = largeView()
        self.smallView = smallView()
        self._isOpen = isOpen
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.cornerRadius = cornerRadius
    }
    
    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight
    }

    private var indicator: some View {
        RoundedRectangle(cornerRadius: Constants.radius)
            .fill(Color.secondary)
            .frame(
                width: Constants.indicatorWidth,
                height: Constants.indicatorHeight
        )
    }

    @GestureState private var translation: CGFloat = 0

    @available(iOS 16.0, *)
    public var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                self.indicator.padding()
                
                if isOpen {
                    self.largeView
                        .frame(width: .infinity)
                } else {
                    self.smallView
                        .frame(width: .infinity)
                }
            }
            
            .frame(width: .infinity, height: self.maxHeight, alignment: .top)
            .background(Color(.secondarySystemBackground))
            .clipShape(
                .rect(
                    topLeadingRadius: cornerRadius,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: cornerRadius
                )
            )
            .shadow(color: shadowColor, radius: shadowRadius)
            
            .frame(height: geometry.size.height + 60, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0))
            .animation(.interactiveSpring(), value: isOpen)
            .animation(.interactiveSpring(), value: translation)
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                }.onEnded { value in
                    let snapDistance = self.maxHeight * Constants.snapRatio
                    guard abs(value.translation.height) > snapDistance else {
                        return
                    }
                    self.isOpen = value.translation.height < 0
                }
            )
        }
    }
}
