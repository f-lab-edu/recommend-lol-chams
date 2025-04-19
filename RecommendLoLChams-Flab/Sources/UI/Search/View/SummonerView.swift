//
//  SummonerView.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 3/15/25.
//

import SwiftUI

struct SummonerView: View {
    private let profile: Profile
    
    init(profile: Profile) {
        self.profile = profile
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 20) {
                AsyncImage(url: profile.summoner.profileImageURL) { image in
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
                        Text(profile.summoner.gameName)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(Color.Palette.gray3)
                        L10n.SummonerSearch.summonerTagline.text(profile.summoner.tagLine)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(Color.Palette.gray3)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            
            VStack {
                ForEach(profile.ranks) { rank in
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
    }
}

#Preview {
    SummonerView(profile: .mock)
}
