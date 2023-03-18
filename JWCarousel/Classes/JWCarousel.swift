//
//  FramePreferenceKey+JWCarousel.swift
//  JWCarousel
//
//  Created by 이지원 on 2023/03/19.
//

import SwiftUI

public struct JWCarousel<Item, ItemView: View> : View {
    
    @Binding var items: [Item]
    @Binding var currentIndex: Int

    @State private var pointX: CGFloat = 0
    @State private var size: CGSize = .zero
    @State private var isDragging = false

    @GestureState private var offsetState: CGSize = .zero

    var spacing: CGFloat = 0
    var itemWidth: CGFloat = 0
    var itemHeight: CGFloat = 0
    var opacity: Double = 0.0
    var sizeScale: Double = 0.0
    var itemView: (Item) -> ItemView

    public init(items: Binding<[Item]>, currentIndex: Binding<Int>,  spacing: CGFloat, itemWidth: CGFloat, itemHeight: CGFloat, opacity: Double, sizeScale: Double, @ViewBuilder itemView: @escaping (Item) -> ItemView) {
        self._items = items
        self._currentIndex = currentIndex
        self.spacing = spacing
        self.itemWidth = itemWidth
        self.itemHeight = itemHeight
        self.opacity = opacity
        self.sizeScale = sizeScale
        self.itemView = itemView
    }
    
    private var firstItemPositionX: CGFloat {
        let length = CGFloat(max(0, items.count - 1))
        return ((itemWidth + spacing) * length + size.width) / 2
    }
    
    public var body: some View {
        ZStack {
            GeometryReader { proxy in
                HStack(spacing: spacing) {
                    ForEach (items.indices, id: \.self) { index in
                        ZStack {
                            itemView(items[index])
                                .frame(width: itemWidth, height: itemHeight)
                        }
                        .scaleEffect(max(1.0 - abs(distance(index)) * sizeScale, 0.0001))
                        .zIndex(1.0 - abs(distance(index) * 0.1))
                        .opacity(1.0 - abs(distance(index) * opacity))
                        .frame { value in
                            let range = itemWidth + spacing

                            if isDragging {
                                var ratio: CGFloat {
                                    switch value.origin.x {
                                    case proxy.size.width / 2 - itemWidth / 2 ... proxy.size.width + itemWidth / 2 + spacing:
                                        let offset = (proxy.size.width + itemWidth / 2 + spacing) - (proxy.size.width / 2 - value.origin.x)
                                        return offset / range

                                    case spacing / 2 ... proxy.size.width / 2 - itemWidth / 2:
                                        let offset = (proxy.size.width - itemWidth)/2 - value.origin.x
                                        return 1 - offset / range

                                    default:
                                        return 0
                                    }
                                }

                                withAnimation {
                                    if 0.5 < ratio {
                                        currentIndex = index
                                    }
                                }
                            }
                        }
                        .onTapGesture {
                            withAnimation {
                                currentIndex = index
                                pointX = -(spacing + itemWidth) * CGFloat(currentIndex)
                            }
                        }
                    }
                }
                .position(x: firstItemPositionX + pointX + offsetState.width, y: proxy.size.width / 2)
                .task {
                    size = proxy.size
                }
            }
        }
        .onAppear {
            withAnimation {
                pointX = -(CGFloat(currentIndex) * itemWidth + CGFloat(currentIndex) * spacing)
            }
        }
        .gesture(
        DragGesture()
            .updating($offsetState) { currentState, gestureSTate, transaction in
                gestureSTate = currentState.translation
            }
            .onChanged { value in
                isDragging = true
            }
            .onEnded { value in
                isDragging = false
                pointX += value.translation.width
                
                withAnimation(.spring(response: 0.5, dampingFraction: 0.9, blendDuration: 0)) {
                    pointX = -(CGFloat(currentIndex) * itemWidth + (CGFloat(currentIndex) * spacing))
                }
                
                let haptic = UIImpactFeedbackGenerator(style: .soft)
                haptic.impactOccurred()
            }
        )
        .frame(height: itemHeight)
    }
    
    private func distance(_ index: Int) -> Double {
        return Double(currentIndex - index)
    }
}
