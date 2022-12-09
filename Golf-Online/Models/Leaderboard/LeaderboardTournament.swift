import Foundation

struct LeaderboardTournament: Codable {
    var id: Int
    var type: String
    var tour_id: Int
    var name: String
    var country: String
    var course: String
    var start_date: String
    var end_date: String
    var timezone: String
    var prize_fund: String
    var fund_currency: String

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case tour_id
        case name
        case country
        case course
        case start_date
        case end_date
        case timezone
        case prize_fund
        case fund_currency
    }
}
