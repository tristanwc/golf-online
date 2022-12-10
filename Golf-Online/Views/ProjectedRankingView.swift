
import SwiftUI

struct ProjectedRankingView: View {
    @State private var projectedRanking: PGAProjectedRanking?
    @State private var players = [ProjectedRanking]()
    private var viewModel = ViewModel()
    var body: some View {
        VStack {
            Text("Projected Ranking")
                .font(.title)
            NavigationView {
                List {
                    HStack {
                        Text("P.POS")
                            .frame(width: 45, alignment: .leading)
                        Text("PLAYER")
                        Spacer()
                        Text("P.PTS")
                            .frame(alignment: .leading)
                    }
                    ForEach(players, id: \.player_id) { golfer in
                        HStack {
                            Text("\(golfer.projected_rank)")
                                .frame(width: 40, alignment: .leading)
                            Text("\(golfer.first_name) \(getCondensedLastName(lastName: golfer.last_name)).")
                            Spacer()
                            Text("\(golfer.projected_points)")
                                .frame(alignment: .leading)
                        }
                    }
                }
            }
        }
        .onAppear(perform: {
            projectedRanking = (self.viewModel.getProjectedRanking())
            players = (projectedRanking?.results?.rankings)!
        })
    }

    func getCondensedLastName(lastName: String) -> String {
        let startIndex = lastName.startIndex
        let endIndex = lastName.index(startIndex, offsetBy: 1)
        return String(lastName[startIndex ..< endIndex])
    }
}

extension ProjectedRankingView {
    private struct ViewModel {
        func getProjectedRanking() -> PGAProjectedRanking {
            return GolfDataService().getProjectedRanking()
        }
    }
}
