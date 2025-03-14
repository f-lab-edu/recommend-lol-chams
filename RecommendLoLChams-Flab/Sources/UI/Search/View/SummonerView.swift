//
//  SummonerView.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 3/15/25.
//

import SwiftUI

struct SummonerView: View {
    @ObservedObject var viewModel: SummonerViewModel
    
    init(viewModel: SummonerViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 20) {
                AsyncImage(url: viewModel.info.profileImageURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProfilePlaceholder()
                }
                .cornerRadius(10)
                .frame(width: 30, height: 30)
                
                VStack(alignment: .leading) {
                    HStack(spacing: 5) {
                        Text(viewModel.info.gameName)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(Color.Palette.gray3)
                        L10n.SummonerSearch.summonerTagline.text(viewModel.info.tagLine)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(Color.Palette.gray3)
                    }
                }
                
                Spacer()
                
                L10n.SummonerSearch.summonerPlaying.text
                    .font(.system(size: 13))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(
                        Capsule().stroke(lineWidth: 1)
                    )
                    .foregroundStyle(viewModel.isPlaying ? Color.Palette.green : Color.Palette.gray1)
            }
            .padding(.horizontal, 20)
            Spacer()
        }
        .onAppear {
            viewModel.checkPlaying.send()
        }
    }
    
    struct ProfilePlaceholder: View {
        init() {}
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.Palette.gray1)
                Image(asset: Asset.imageSearchProfilePlaceholder)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 10)
            }
            .frame(width: 50, height: 50)
        }
    }
}
