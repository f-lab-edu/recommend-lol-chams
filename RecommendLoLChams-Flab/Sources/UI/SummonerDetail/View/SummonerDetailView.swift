//
//  SummonerDetailView.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 4/19/25.
//

import SwiftUI

struct SummonerDetailView: View {
    private let profile: Profile
    
    init(profile: Profile) {
        self.profile = profile
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                BasicInfoView(profile: profile)
                PositionView()
            }
            .padding(.horizontal, 20)
        }
    }
}

private struct BasicInfoView: View {
    private let profile: Profile
    private let isPlaying: Bool = true
    
    init(profile: Profile) {
        self.profile = profile
    }
    
    var body: some View {
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
    }
}

private struct PositionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            L10n.SummonerDetail.PreferPosition.title.text
                .font(.system(size: 20, weight: .heavy))
                .foregroundStyle(Color.Palette.gray3)
            VStack(alignment: .leading, spacing: 10) {
                ForEach(Array(0..<3), id: \.self) { i in
                    HStack(spacing: 10) {
                        L10n.SummonerDetail.PreferPosition.rank.text("\(i+1)")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(i == 0 ? Color.Palette.blue7 : Color.Palette.gray1)
                        Text("포지션")
                            .font(.system(size: 16, weight: i == 0 ? .bold : .medium))
                            .foregroundStyle(i == 0 ? Color.Palette.blue4 : Color.Palette.gray1)
                        Text("50%")
                            .font(.system(size: 16, weight: i == 0 ? .bold : .medium))
                            .foregroundStyle(i == 0 ? Color.Palette.blue4 : Color.Palette.gray1)
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 10)
        }
    }
}

#Preview {
    SummonerDetailView(profile: .mock)
}
