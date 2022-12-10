import FirebaseFirestoreSwift
import Foundation

struct Fixture: Codable {
    var results: [Tournament]?
}

struct Tournament: Codable {
    var id: Int
    var type: String
    var name: String
    var country: String
    var course: String
    var start_date: String
    var end_date: String
    var timezone: String
    var prize_fund: String
    var fund_currency: String

    enum CodingKeys: CodingKey {
        case id
        case type
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
