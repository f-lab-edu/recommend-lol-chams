//
//  Match.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 2/22/25.
//

struct Match {
    let duration: Int                   // 진행 시간(초단위)
    let queueType: Queue?               // 큐 타입
    let participants: [Participant]     // 10명의 소환사 세부 전적
    
    var durationTime: String {
        let seconds = duration % 60
        let minutes = duration / 60
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, remainingMinutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
}

extension Match {
    enum Queue {
        case soloOrDuoRank              // 개인/2인 랭크
        case flexRank                   // 자유 랭크 구분
        case normal                     // 일반 게임
        case pvp                        // PvP
        
        static func toType(fromId id: Int) -> Self? {
            switch id {
            case 420:
                return .soloOrDuoRank
            case 440:
                return .flexRank
            case 400, 430, 450:
                return .normal
            case 870:
                return .pvp
            default:
                return nil
            }
        }
    }
    
    struct Participant {
        let isMe: Bool
        let summonerName: String
        let champion: Champion
        let position: Position
        let kills: Int
        let deaths: Int
        let assists: Int
        let dealtDamage: Int
        let earnedGold: Int
        
        var kda: String { "\(kills) / \(deaths) / \(assists)" }
    }
    
    struct Champion {
        let id: Int
        let name: String
    }
    
    enum Position {
        case top
        case jungle
        case mid
        case adc
        case support
        
        static func toType(fromName name: String) -> Self? {
            switch name {
            case "TOP":
                return .top
            case "JUNGLE":
                return .jungle
            case "MID":
                return .mid
            case "BOTTOM":
                return .adc
            case "UTILITY":
                return .support
            default:
                return nil
            }
        }
    }
}

extension Match {
    static let mock = Match(
        duration: 1000000,
        queueType: .soloOrDuoRank,
        participants: Array(
            repeating: Match.Participant(
                isMe: false,
                summonerName: "소환사명",
                champion: Champion(id: 0, name: "챔피언명"),
                position: .mid,
                kills: 10,
                deaths: 2,
                assists: 20,
                dealtDamage: 100000,
                earnedGold: 1000000
            ),
            count: 10
        )
    )
}
