import SwiftSoup
import SwiftUI

struct HomeView: View {
    @State private var leaderboard: Leaderboard?
    @State private var players = [LeaderboardPlayer]()
    @State private var showingTournaments = false
    private var viewModel = ViewModel()
    var tournament_id = 484
    var body: some View {
        NavigationView {
            VStack {
//                Text("\(leaderboard?.results?.tournament.name ?? "ERROR_TOURNAMENT_TITLE")")
//                    .font(.title)
                Text("\(leaderboard?.results?.tournament.course ?? "ERROR_COURSE_NAME")").font(.subheadline)
                List {
                    ForEach(players, id: \.player_id) { player in
                        NavigationLink(destination: ScorePageView(tournament_id: tournament_id, player: player), label: {
                            PlayerCellView(player: player)
                        })
                    }
                }
            }
            .navigationTitle("\(leaderboard?.results?.tournament.name ?? "ERROR_TOURNAMENT_TITLE")")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing:
                Button {
                    showingTournaments = true
                }
                label: {
                    VStack {
                        Text("Events").font(.subheadline)
                        Image(systemName: "list.dash")
                    }
                }
                .popover(isPresented: $showingTournaments) {
                    FixtureListView()
                })
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            leaderboard = self.viewModel.getLeaderboard(tournament_id: tournament_id)
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
        func getLeaderboard(tournament_id: Int) -> Leaderboard {
            return GolfDataService().getLeaderboard(tournament_id: tournament_id)
        }
    }
}
