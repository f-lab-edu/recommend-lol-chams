// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

enum L10n {
    enum SummonerDetail {
        enum PreferPosition {
            /// Top %@.
            static let rank: LocalizableKey<LocalizableParameterCount1> = .init(key: "summoner_detail.prefer_position.rank")
            /// 선호 포지션
            static let title: LocalizableKey<LocalizableParameterCount0> = .init(key: "summoner_detail.prefer_position.title")
        }
    }
    enum SummonerSearch {
        /// 해당되는 소환사가 없습니다!
        static let empty: LocalizableKey<LocalizableParameterCount0> = .init(key: "summoner_search.empty")
        /// 이제\n플레이어 이름 + 태그로\n전적을 검색하세요!
        static let previewTitle: LocalizableKey<LocalizableParameterCount0> = .init(key: "summoner_search.preview_title")
        /// 검색
        static let searchbarButtonTitle: LocalizableKey<LocalizableParameterCount0> = .init(key: "summoner_search.searchbar_button_title")
        /// 플레이어 이름 + #KR1
        static let searchbarPlaceholder: LocalizableKey<LocalizableParameterCount0> = .init(key: "summoner_search.searchbar_placeholder")
        /// 연승중🔥
        static let summonerIshotstreak: LocalizableKey<LocalizableParameterCount0> = .init(key: "summoner_search.summoner_ishotstreak")
        /// 패 : %@
        static let summonerLoses: LocalizableKey<LocalizableParameterCount1> = .init(key: "summoner_search.summoner_loses")
        /// 게임중
        static let summonerPlaying: LocalizableKey<LocalizableParameterCount0> = .init(key: "summoner_search.summoner_playing")
        /// #%@
        static let summonerTagline: LocalizableKey<LocalizableParameterCount1> = .init(key: "summoner_search.summoner_tagline")
        /// 승 : %@
        static let summonerWins: LocalizableKey<LocalizableParameterCount1> = .init(key: "summoner_search.summoner_wins")
    }
    enum Tab {
        /// 챔피언 추천
        static let recommendChampion: LocalizableKey<LocalizableParameterCount0> = .init(key: "tab.recommend_champion")
        /// 전적검색
        static let searchScore: LocalizableKey<LocalizableParameterCount0> = .init(key: "tab.search_score")
    }
}

protocol LocalizableParameterCount {}

struct LocalizableParameterCount0: LocalizableParameterCount {}
struct LocalizableParameterCount1: LocalizableParameterCount {}
struct LocalizableParameterCount2: LocalizableParameterCount {}
struct LocalizableParameterCount3: LocalizableParameterCount {}
struct LocalizableParameterCount4: LocalizableParameterCount {}
struct LocalizableParameterCount5: LocalizableParameterCount {}

struct LocalizableKey<T: LocalizableParameterCount> {
    let key: String
}

// periphery:ignore
extension LocalizableKey where T == LocalizableParameterCount0 {
    var value: String {
        return L10n.tr(key)
    }
}

// periphery:ignore
extension LocalizableKey where T == LocalizableParameterCount1 {
    func value(_ p0: String) -> String {
        return L10n.tr(key, p0)
    }
}

// periphery:ignore
extension LocalizableKey where T == LocalizableParameterCount2 {
    func value(_ p0: String, _ p1: String) -> String {
        return L10n.tr(key, p0, p1)
    }
}

// periphery:ignore
extension LocalizableKey where T == LocalizableParameterCount3 {
    func value(_ p0: String, _ p1: String, _ p2: String) -> String {
        return L10n.tr(key, p0, p1, p2)
    }
}

// periphery:ignore
extension LocalizableKey where T == LocalizableParameterCount4 {
    func value(_ p0: String, _ p1: String, _ p2: String, _ p3: String) -> String {
        return L10n.tr(key, p0, p1, p2, p3)
    }
}

// periphery:ignore
extension LocalizableKey where T == LocalizableParameterCount5 {
    func value(_ p0: String, _ p1: String, _ p2: String, _ p3: String, _ p4: String) -> String {
        return L10n.tr(key, p0, p1, p2, p3, p4)
    }
}

extension L10n {
    static func tr(_ key: String, _ args: CVarArg...) -> String {
        let format = NSLocalizedString(key, tableName: "Localizable", bundle: Bundle(for: BundleToken.self), comment: "")
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

private final class BundleToken {}

import struct SwiftUI.Text
import struct SwiftUI.LocalizedStringKey

// periphery:ignore
extension LocalizableKey where T == LocalizableParameterCount0 {
    var text: Text {
        return Text(.init(stringLiteral: key), tableName: "Localizable", bundle: Bundle(for: BundleToken.self))
    }
}

// periphery:ignore
extension LocalizableKey where T == LocalizableParameterCount1 {
    func text(_ p0: String) -> Text {
        return Text.localized(key, params: [p0])
    }
}

// periphery:ignore
extension LocalizableKey where T == LocalizableParameterCount2 {
    func text(_ p0: String, _ p1: String) -> Text {
        return Text.localized(key, params: [p0, p1])
    }
}

// periphery:ignore
extension LocalizableKey where T == LocalizableParameterCount3 {
    func text(_ p0: String, _ p1: String, _ p2: String) -> Text {
        return Text.localized(key, params: [p0, p1, p2])
    }
}

// periphery:ignore
extension LocalizableKey where T == LocalizableParameterCount4 {
    func text(_ p0: String, _ p1: String, _ p2: String, _ p3: String) -> Text {
        return Text.localized(key, params: [p0, p1, p2, p3])
    }
}

// periphery:ignore
extension LocalizableKey where T == LocalizableParameterCount5 {
    func text(_ p0: String, _ p1: String, _ p2: String, _ p3: String, _ p4: String) -> Text {
        return Text.localized(key, params: [p0, p1, p2, p3, p4])
    }
}

private extension Text {
    static func localized(_ key: String, params: [String]) -> Text {
        let format = NSLocalizedString(key, tableName: "Localizable", bundle: Bundle(for: BundleToken.self), comment: "")
        let paramterRemovedKey = format.replacingOccurrences(of: "%@", with: "")
        var interpolation = LocalizedStringKey.StringInterpolation(literalCapacity: paramterRemovedKey.count, interpolationCount: params.count)
        interpolation.appendLiteral(paramterRemovedKey)
        params.forEach { interpolation.appendInterpolation($0) }
        return Text(.init(stringInterpolation: interpolation), tableName: "Localizable", bundle: Bundle(for: BundleToken.self))
    }
}

// swiftlint:enable all
