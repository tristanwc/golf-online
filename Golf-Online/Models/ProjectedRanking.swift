import Foundation

struct PGAProjectedRanking: Codable {
    var results: ProjectedRankingResult?
}

struct ProjectedRankingResult: Codable {
    var rankings: [ProjectedRanking]
}

struct ProjectedRanking: Codable {
    var player_id: Int
    var first_name: String
    var last_name: String
    var projected_points: String
    var projected_rank: String
    var projected_event_points: String
    var current_rank: Int
    var current_points: String
    var movement: Int
    var updated_at: String
}
