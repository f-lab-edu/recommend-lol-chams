//
//  RecommendView.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 1/17/25.
//

import SwiftUI

struct RecommendView: View {
    private let tags: [String] = ["내성적", "외향적"]

    var body: some View {
        List(tags, id: \.self) { tag in
            Text(tag)
        }
    }
}

#Preview {
    RecommendView()
}
