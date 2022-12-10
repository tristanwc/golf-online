
import SwiftUI

struct WorldRankingView: View {
    @State private var worldRanking: WorldRanking?
    @State private var players = [Player]()
    private var viewModel = ViewModel()
    var body: some View {
        VStack {
            Text("World Ranking")
                .font(.title)
            NavigationView {
                List {
                    HStack {
                        Text("POS")
                            .frame(width: 50, alignment: .leading)
                        Text("PLAYER")
                        Spacer()
                        Text("PTS")
                    }
                    ForEach(players, id: \.player_id) { golfer in
                        HStack {
                            Text("\(golfer.position)")
                                .frame(width: 50, alignment: .leading)
                            Text("\(golfer.player_name)")
                            Spacer()
                            Text("\(golfer.total_points)")
                        }
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
