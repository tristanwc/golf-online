import SwiftUI

struct ScorePageView: View {
    @State private var scorecard: PGAScorecard?
    @State private var totalRounds: Int = 0
    let tournament_id: Int
    let player: LeaderboardPlayer
    var viewModel = ViewModel()
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("\(Golf_Online.countryFlag(from: player.country))")
                        .padding([.trailing], 5)
                    Text("\(self.player.first_name) \(self.player.last_name)")
                }
                .font(.title).padding([.bottom], 10)
                Text("Position: \(player.position)")
                Text("Course: \(scorecard?.results?.courses[0].name ?? "ERROR_COURSE_NAME")")

                ForEach(0 ..< totalRounds, id: \.self) { index in
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Round \(index + 1)")
                            .font(.title3).frame(alignment: .leading)
                        ScorecardView(viewModel: getScorecardViewModel(index: index))
                        Divider()
                    }
                    .padding([.top], 10)
                }
            }
            .padding([.leading], 20)
        }
        .onAppear(perform: {
            scorecard = self.viewModel.getScorecard(tournament_id: tournament_id, player_id: player.player_id)
            totalRounds = (scorecard?.results?.scorecard.count)!
        })
    }

    private func getScorecardViewModel(index: Int) -> ScorecardView.ViewModel {
        let courseData = scorecard?.results?.courses[0]
        let holeDetails = scorecard?.results?.rounds_holes_breakdown.rounds[0].courses[0].holes
        let holeScores = scorecard?.results?.scorecard[index].holes
        let vm = ScorecardView.ViewModel(roundNumber: index,
                                         courseData: courseData,
                                         holeDetails: holeDetails,
                                         holeScores: holeScores)
        return vm
    }
}

extension ScorePageView {
    struct ViewModel {
        func getScorecard(tournament_id: Int, player_id: Int) -> PGAScorecard {
            return GolfDataService().getScorecard(tournament_id: tournament_id, player_id: player_id)
        }
    }
}
