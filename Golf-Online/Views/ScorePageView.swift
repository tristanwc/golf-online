import SwiftUI

struct ScorePageView: View {
    @State private var scorecard: PGAScorecard?
    @State private var totalRounds: Int = 0
    let player: LeaderboardPlayer
    var viewModel = ViewModel()
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("\(Golf_Online.countryFlag(from: player.country))")
                        .padding([.trailing], 5)
                    Text("\(self.player.first_name) \(self.player.last_name)")
                }.font(.title)

                ForEach(0 ..< totalRounds, id: \.self) { index in
                    Text("Round: \(index + 1)")
                        .font(.title3)
                    ScorecardView(player: player)
                }
                .padding([.bottom], 10).frame(alignment: .leading)
            }
            .onAppear(perform: {
                scorecard = self.viewModel.getScorecard(player_id: player.player_id)
                totalRounds = (scorecard?.results?.scorecard.count)!
            })
        }
    }
}

extension ScorePageView {
    struct ViewModel {
        func getScorecard(player_id: Int) -> PGAScorecard {
            return GolfDataService().getScorecard(player_id: player_id)
        }
    }
}
