
import Foundation

struct LeaderboardPlayer: Codable {
    var position: Int
    var player_id: Int
    var first_name: String
    var last_name: String
    var country: String
    var holes_played: Int
    var current_round: Int
    var status: String
    var strokes: Int
    var updated: String
    var prize_money: String?
    var ranking_points: String?
    var total_to_par: Int

    enum CodingKeys: String, CodingKey {
        case position
        case player_id
        case first_name
        case last_name
        case country
        case holes_played
        case current_round
        case status
        case strokes
        case updated
        case prize_money
        case ranking_points
        case total_to_par
    }
}
