//
//  ProfilePlaceholder.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 4/19/25.
//

import SwiftUI

struct ProfilePlaceholder: View {
    init() {}
    
    var body: some View {
        ZStack {
            Color.Palette.gray1
            Image(asset: Asset.imageSearchProfilePlaceholder)
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 15)
        }
    }
}
