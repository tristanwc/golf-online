
import SwiftUI

struct WorldRankingView: View {
    @State private var worldRanking: WorldRanking?
    @State private var players = [Player]()
    private var viewModel = ViewModel()
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(players, id: \.player_id) { golfer in
                        Text("\(golfer.player_name), \(golfer.position)")
                    }
                }
            }
        }
        .onAppear(perform: {
            worldRanking = (self.viewModel.getWorldRanking())
            players = (worldRanking?.results?.rankings)!
        })
    }
}

struct WorldRankingView_Previews: PreviewProvider {
    static var previews: some View {
        WorldRankingView()
    }
}

extension WorldRankingView {
    private struct ViewModel {
        func getWorldRanking() -> WorldRanking {
            return GolfDataService().getWorldRanking()
        }
    }
}
