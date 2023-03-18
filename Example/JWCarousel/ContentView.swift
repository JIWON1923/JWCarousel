//
//  ContentView.swift
//  JWCarousel_Example
//
//  Created by 이지원 on 2023/03/19.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI

import SwiftUI
import JWCarousel

struct ContentView: View {
    
    @State var items = [
        Item(id: 1, title: "1번째 아이템"),
        Item(id: 2, title: "2번째 아이템"),
        Item(id: 3, title: "3번째 아이템"),
        Item(id: 4, title: "4번째 아이템"),
        Item(id: 5, title: "5번째 아이템"),
        Item(id: 6, title: "6번째 아이템"),
        Item(id: 7, title: "7번째 아이템")
    ]
    
    @State var currentIndex = 0
    let spacing: CGFloat  = -100
    let itemWidth: CGFloat = 250
    let itemHeight: CGFloat = 250
    
    var body: some View {
        JWCarousel(items: $items,
                   currentIndex: $currentIndex,
                   spacing: spacing,
                   itemWidth: itemWidth,
                   itemHeight: itemHeight,
                   opacity: 0.3,
                   sizeScale: 0.25) { item in
            ItemView(item: item)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
