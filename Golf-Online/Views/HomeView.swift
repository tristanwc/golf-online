import SwiftSoup
import SwiftUI

struct HomeView: View {
    @State private var leaderboard: Leaderboard?
    @State private var players = [LeaderboardPlayer]()
    private var viewModel = ViewModel()
    var body: some View {
        NavigationView {
            VStack {
                Text("\(leaderboard?.results?.tournament.name ?? "ERROR_TOURNAMENT_TITLE")")
                    .font(.title)
                List {
                    ForEach(players, id: \.player_id) { player in
                        NavigationLink(destination: ScorecardView(player: player), label: {
                            PlayerCellView(player: player)
                        })
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            leaderboard = self.viewModel.getLeaderboard()
            players = (leaderboard?.results?.leaderboard)!
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeView {
    private struct ViewModel {
        func getLeaderboard() -> Leaderboard {
            return GolfDataService().getLeaderboard()
        }
    }
}
