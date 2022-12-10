import Foundation

struct WorldRankingResult: Codable {
    var rankings: [Player]
    var last_updated: String
}
