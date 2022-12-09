import Foundation

struct Player: Codable {
    var position: Int
    var movement: Int
    var player_id: Int
    var player_name: String
    var num_events: Int
    var avg_points: String
    var total_points: String
    var points_lost: String
    var points_gained: String

    enum CodingKeys: String, CodingKey {
        case position
        case movement
        case player_id
        case player_name
        case num_events
        case avg_points
        case total_points
        case points_lost
        case points_gained
    }
}
