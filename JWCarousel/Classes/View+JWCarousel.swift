//
//  View+JWCarousel.swift
//  JWCarousel
//
//  Created by 이지원 on 2023/03/19.
//

import SwiftUI

public extension View {
    
    func frame(perform: @escaping (CGRect) -> Void) -> some View {
        background(
            GeometryReader {
                Color.clear
                    .preference(key: FramePreferenceKey.self, value: $0.frame(in: .global))
            }
        )
        .onPreferenceChange(FramePreferenceKey.self) { value in
            DispatchQueue.main.async {
                perform(value)
            }
        }
    }
    
}
