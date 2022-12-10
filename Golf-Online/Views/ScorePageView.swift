import SwiftUI

struct ScorePageView: View {
    @State private var scorecard: PGAScorecard?
    @State private var totalRounds: Int = 0
    let player: LeaderboardPlayer
    var viewModel = ViewModel()
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
            }
            .padding([.bottom], 10).frame(alignment: .leading)
                HStack {
                    Text("\(Golf_Online.countryFlag(from: player.country))")
                        .padding([.trailing], 5)
                    Text("\(self.player.first_name) \(self.player.last_name)")
                }.font(.title).padding([.bottom], 30)

                ForEach(0 ..< totalRounds, id: \.self) { index in
                    Text("Round \(index + 1)")
                        .font(.title3)
                    ScorecardView(viewModel: getScorecardViewModel(index: index))
                Divider()
            }
            .onAppear(perform: {
                scorecard = self.viewModel.getScorecard(player_id: player.player_id)
                totalRounds = (scorecard?.results?.scorecard.count)!
            }
            ).padding([.leading], 20)
        }
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
        func getScorecard(player_id: Int) -> PGAScorecard {
            return GolfDataService().getScorecard(player_id: player_id)
        }
    }
}
