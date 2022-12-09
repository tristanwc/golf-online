import SwiftUI

struct ScorecardView: View {
    @State private var scorecard: PGAScorecard?
    @State private var holeDetails = [HoleDetail]()
    @State private var roundScores = [Scorecard]()
    @State private var holeScores = [HoleScore]()
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
            HStack {
                Text("\(Golf_Online.countryFlag(from: player.country))")
                    .padding([.trailing], 5)
                Text("\(self.player.first_name) \(self.player.last_name)")
            }.font(.title)
            HStack(spacing: 0) {
                Text("Hole").frame(width: 80)
                ForEach(holeDetails.prefix(9), id: \.hole_num) { detail in
                    ZStack {
                        Rectangle().opacity(0.2)
                        Text(detail.hole_num)
                    }.frame(width: 30, height: 30)
                }
            }
            Divider().frame(width: 270).padding([.leading], 80)
            HStack(spacing: 0) {
                Text("Par").frame(width: 80)
                ForEach(holeDetails.prefix(9), id: \.hole_num) { detail in
                    ZStack {
                        Rectangle().opacity(0.1)
                        Text(detail.par)
                    }.frame(width: 30, height: 30)
                }
            }
            Divider().frame(width: 270).padding([.leading], 80)
            HStack(spacing: 0) {
                Text("Score").frame(width: 80)
                ForEach(holeScores.prefix(9), id: \.hole_number) { score in
                    ZStack {
                        Rectangle().opacity(0.1)
                        Text(score.score)
                    }.frame(width: 30, height: 30)
                }
            }
            Divider().frame(width: 270).padding([.leading], 80)
        }.frame(maxWidth: .infinity)
            .onAppear(perform: {
                scorecard = self.viewModel.getScorecard(player_id: player.player_id)
                holeDetails = (scorecard?.results?.rounds_holes_breakdown.rounds[0].courses[0].holes)!
                roundScores = (scorecard?.results?.scorecard)!
                setRoundScore(round: 3)
            })
    }

    func setRoundScore(round: Int) {
        holeScores = (scorecard?.results?.scorecard[round].holes)!
    }
}

extension ScorecardView {
    struct ViewModel {
        func getScorecard(player_id: Int) -> PGAScorecard {
            print(player_id)
            return GolfDataService().getScorecard(player_id: player_id)
        }
    }
}
