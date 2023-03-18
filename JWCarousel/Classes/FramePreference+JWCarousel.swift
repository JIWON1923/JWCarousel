//
//  FramePreference+JWCarousel.swift
//  JWCarousel
//
//  Created by 이지원 on 2023/03/19.
//

import SwiftUI

public struct FramePreferenceKey: PreferenceKey {
    public static var defaultValue: CGRect = .zero
    public static func reduce(value: inout CGRect, nextValue: () -> CGRect) {}
}
