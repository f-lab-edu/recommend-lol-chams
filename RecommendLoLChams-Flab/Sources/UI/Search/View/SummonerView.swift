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
            HStack(alignment: .center, spacing: 20) {
                AsyncImage(url: viewModel.profile.summoner.profileImageURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProfilePlaceholder()
                }
                .clipShape(Circle())
                .frame(width: 80, height: 80)
                
                VStack(alignment: .leading) {
                    HStack(spacing: 5) {
                        Text(viewModel.profile.summoner.gameName)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(Color.Palette.gray3)
                        L10n.SummonerSearch.summonerTagline.text(viewModel.profile.summoner.tagLine)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(Color.Palette.gray3)
                    }
                }
                
                Spacer()
                
                Group {
                    if viewModel.isPlaying {
                        Circle()
                            .foregroundStyle(Color.Palette.green)
                    } else {
                        Circle()
                            .stroke(lineWidth: 1)
                            .foregroundStyle(Color.Palette.gray1)
                    }
                }
                .frame(width: 14, height: 14)
            }
            .padding(.horizontal, 20)
            
            VStack {
                ForEach(viewModel.profile.ranks) { rank in
                    VStack(alignment: .leading) {
                        Text(rank.queue.description)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(Color.Palette.grayCool)
                        HStack(spacing: 20) {
                            rank.tier.imageAsset.swiftUIImage
                                .resizable()
                                .frame(width: 60, height: 60)
                            VStack(alignment: .leading, spacing: 6) {
                                L10n.SummonerSearch.summonerWins.text(rank.wins.description)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundStyle(Color.Palette.blue3)
                                L10n.SummonerSearch.summonerLoses.text(rank.loses.description)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundStyle(Color.Palette.gray15)
                            }
                            Spacer()
                            L10n.SummonerSearch.summonerIshotstreak.text
                                .font(.system(size: 15, weight: .heavy))
                        }
                        .padding(.leading, 5)
                        Divider()
                            .padding(.vertical, 5)
                    }
                }
                .padding(.horizontal, 20 + 15)
            }
            .padding(.vertical, 10)
            .background(Color.Palette.gray02)
            Spacer()
        }
        .onAppear {
            viewModel.checkPlaying.send()
        }
    }
    
    private struct ProfilePlaceholder: View {
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
}

#Preview {
    SummonerView(viewModel: SummonerViewModel(summonerSearchApi: MockSearchService(), profile: .mock))
}
