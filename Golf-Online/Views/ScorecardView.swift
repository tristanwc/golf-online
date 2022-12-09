import SwiftUI

struct ScorecardView: View {
    @State private var scorecard: PGAScorecard?
    @State private var courseData: CourseData?
    @State private var holeDetails = [HoleDetail]()
    @State private var holeScores = [HoleScore]()
    @State private var backNineHoleDetails = [HoleDetail]()
    @State private var backNineScores = [HoleScore]()
    @State private var round = 0

    let player: LeaderboardPlayer
    var viewModel = ViewModel()
    // HOLE 1 2 3 4 5 6 7 8 9
    // -------------------------------
    // PAR
    // -------------------------------
    // R1
    // -------------------------------

    var body: some View {
        VStack(spacing: 0) {
            // MARK: Front 9 Scorecard

            Group {
                HStack(spacing: 0) {
                    Text("Hole").frame(width: 50, alignment: .leading)
                    ForEach(holeDetails.prefix(9), id: \.hole_num) { detail in
                        ZStack {
                            Rectangle().opacity(0.2)
                            Text(detail.hole_num)
                        }
                        .frame(width: 25, height: 20)
                    }
                    ZStack {
                        Rectangle().opacity(0.2)
                        Text("OUT")
                            .fixedSize(horizontal: false, vertical: false)
                    }
                    .frame(width: 40, height: 20)
                    Rectangle().opacity(0.2)
                        .frame(width: 40, height: 20)
                }
                HStack(spacing: 0) {
                    Text("Par").frame(width: 50, alignment: .leading)
                    ForEach(holeDetails.prefix(9), id: \.hole_num) { detail in
                        ZStack {
                            Rectangle().opacity(0.1)
                            Text(detail.par)
                        }
                        .frame(width: 25, height: 20)
                    }
                    ZStack {
                        Rectangle().opacity(0.1)
                        Text("\(getFrontNinePar())")
                    }
                    .frame(width: 40, height: 20)
                    Rectangle().opacity(0.1)
                        .frame(width: 40, height: 20)
                }
                HStack(spacing: 0) {
                    Text("Score").frame(width: 50, alignment: .leading)
                    ForEach(holeScores.prefix(9), id: \.hole_number) { score in
                        ZStack {
                            Rectangle().opacity(0.1)
                            Text(score.score)
                        }
                        .frame(width: 25, height: 20)
                    }
                    ZStack {
                        Rectangle().opacity(0.1)
                        Text("\(getFrontNineScore())")
                    }
                    .frame(width: 40, height: 20)
                    Rectangle().opacity(0.1)
                        .frame(width: 40, height: 20)
                }
            }

            // MARK: Back 9 Scorecard

            Group {
                HStack(spacing: 0) {
                    Text("Hole").frame(width: 50, alignment: .leading)
                    ForEach(backNineHoleDetails, id: \.hole_num) { detail in
                        ZStack {
                            Rectangle().opacity(0.2)
                            Text(detail.hole_num)
                        }
                        .frame(width: 25, height: 20)
                    }
                    ZStack {
                        Rectangle().opacity(0.2)
                        Text("IN")
                    }
                    .frame(width: 40, height: 20)
                    ZStack {
                        Rectangle().opacity(0.2)
                        Text("TOT")
                    }
                    .frame(width: 40, height: 20)
                }
                HStack(spacing: 0) {
                    Text("Par").frame(width: 50, alignment: .leading)
                    ForEach(backNineHoleDetails, id: \.hole_num) { detail in
                        ZStack {
                            Rectangle().opacity(0.1)
                            Text(detail.par)
                        }
                        .frame(width: 25, height: 20)
                    }
                    ZStack {
                        Rectangle().opacity(0.1)
                        Text("\(getBackNinePar())")
                    }
                    .frame(width: 40, height: 20)
                    ZStack {
                        Rectangle().opacity(0.1)
                        Text("\(getParTotal())")
                    }
                    .frame(width: 40, height: 20)
                }
                HStack(spacing: 0) {
                    Text("Score").frame(width: 50, alignment: .leading)
                    ForEach(backNineScores, id: \.hole_number) { score in
                        ZStack {
                            Rectangle().opacity(0.1)
                            Text(score.score)
                        }
                        .frame(width: 25, height: 20)
                    }
                    ZStack {
                        Rectangle().opacity(0.1)
                        Text("\(getBackNineScore())")
                    }
                    .frame(width: 40, height: 20)
                    ZStack {
                        Rectangle().opacity(0.1)
                        Text("\(getTotalScore())")
                    }
                    .frame(width: 40, height: 20)
                }
            }
        }
        .onAppear(perform: {
            scorecard = self.viewModel.getScorecard(player_id: player.player_id)
            round = (scorecard?.results?.rounds_holes_breakdown.rounds.count)!
            setRoundScore(round: round - 1)
        })
    }

    func getTotalScore() -> Int {
        return getFrontNineScore() + getBackNineScore()
    }

    func getFrontNineScore() -> Int {
        var frontScore = 0
        for score in holeScores.prefix(9) {
            frontScore += Int(score.score)!
        }
        return frontScore
    }

    func getBackNineScore() -> Int {
        var backScore = 0
        for score in backNineScores {
            backScore += Int(score.score)!
        }
        return backScore
    }

    func getFrontNinePar() -> Int {
        if let frontNinePar = courseData?.par_front {
            return frontNinePar
        }
        return 0
    }

    func getBackNinePar() -> Int {
        if let backNinePar = courseData?.par_back {
            return backNinePar
        }
        return 0
    }

    func getParTotal() -> Int {
        if let parTotal = courseData?.par_total {
            return parTotal
        }
        return 0
    }

    func setRoundScore(round: Int) {
        courseData = (scorecard?.results?.courses[0])!
        holeScores = (scorecard?.results?.scorecard[round].holes)!
        backNineScores = Array((scorecard?.results?.scorecard[round].holes.suffix(from: 9))!)

        holeDetails = (scorecard?.results?.rounds_holes_breakdown.rounds[0].courses[0].holes)!
        backNineHoleDetails = Array((scorecard?.results?.rounds_holes_breakdown.rounds[0].courses[0].holes.suffix(from: 9))!)
    }
}

extension ScorecardView {
    struct ViewModel {
        func getScorecard(player_id: Int) -> PGAScorecard {
            return GolfDataService().getScorecard(player_id: player_id)
        }
    }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}
