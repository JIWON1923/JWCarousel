//
//  ItemView.swift
//  JWCarousel_Example
//
//  Created by 이지원 on 2023/03/19.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI

struct ItemView: View {
    
    let item: Item
    
    var body: some View {
        ZStack {
            Image("\(item.id)")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .shadow(color: Color(.gray), radius: 4, x: 0, y: 4)
        }

    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(item: Item(id: 1, title: "testView"))
    }
}
