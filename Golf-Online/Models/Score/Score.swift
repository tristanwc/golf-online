
import Foundation

struct PGAScorecard: Codable {
    var results: ScorecardData?
}

struct ScorecardData: Codable {
    var courses: [CourseData]
    var scorecard: [Scorecard]
    var rounds_holes_breakdown: Round

    enum CodingKeys: CodingKey {
        case courses
        case scorecard
        case rounds_holes_breakdown
    }
}

struct CourseData: Codable {
    var id: Int
    var name: String
    var par_front: Int
    var par_back: Int
    var par_total: Int

    enum CodingKeys: CodingKey {
        case id
        case name
        case par_front
        case par_back
        case par_total
    }
}

struct Scorecard: Codable {
    var round_num: String
    var holes: [HoleScore]

    enum CodingKeys: CodingKey {
        case round_num
        case holes
    }
}

struct HoleScore: Codable {
    var score: String
    var hole_number: String

    enum CodingKeys: CodingKey {
        case score
        case hole_number
    }
}

struct Round: Codable {
    var rounds: [Rounds]

    enum CodingKeys: CodingKey {
        case rounds
    }
}

struct Rounds: Codable {
    var courses: [Course]

    enum CodingKeys: CodingKey {
        case courses
    }
}

struct Course: Codable {
    var holes: [HoleDetail]

    enum CodingKeys: CodingKey {
        case holes
    }
}

struct HoleDetail: Codable {
    enum CodingKeys: CodingKey {
        case par
        case hole_num
    }

    var par: String
    var hole_num: String
}
