//
//  SearchPreview.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 3/15/25.
//

import SwiftUI

struct SearchPreview: View {
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Image(asset: Asset.imageSearchPreview)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 60)
                    .opacity(0.1)
                // TODO: AttribtedString으로 "플레이어 이름 + 태그"만 강조
                L10n.SummonerSearch.previewTitle.text
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(Color.Palette.black)
                    .multilineTextAlignment(.center)
            }
            Spacer()
        }
    }
}
