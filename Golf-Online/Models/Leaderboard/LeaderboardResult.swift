import Foundation

struct LeaderboardResult: Codable {
    var tournament: LeaderboardTournament
    var leaderboard: [LeaderboardPlayer]?

    enum CodingKeys: CodingKey {
        case tournament
        case leaderboard
    }
}
