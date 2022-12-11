import SwiftSoup
import SwiftUI

struct HomeView: View {
    @State private var leaderboard: Leaderboard?
    @State private var fixture: Fixture?
    @State private var tournaments = [Tournament]()
    @State private var players = [LeaderboardPlayer]()
    @State private var showingTournaments = false
    private var viewModel = ViewModel()
    @State private var initialStart = true
    @State private var tournament_id = 0
    var body: some View {
        NavigationView {
            VStack {
                Text("\(leaderboard?.results?.tournament.course ?? "ERROR_COURSE_NAME")").font(.subheadline)
                List {
                    HStack {
                        Text("POS").frame(width: 35)
                            .frame(alignment: .leading)
                        Text("PLAYER").padding([.leading])
                        Spacer()
                        Text("SCORE")
                            .frame(alignment: .trailing)
                    }
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
                    FixtureListView(tournament_id: $tournament_id, showingTournaments: $showingTournaments, viewModel: getFixtureListViewModel())
                })
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            fixture = self.viewModel.getFixture()
            tournaments = (fixture?.results) ?? [Tournament]()
            if !tournaments.isEmpty {
                tournaments = viewModel.getPastTournaments(tournaments: tournaments)
                tournament_id = self.tournaments[tournaments.endIndex - 1].id
            } else {
                tournament_id = 484
            }

        })
        .onChange(of: tournament_id) { _ in
            leaderboard = self.viewModel.getLeaderboard(tournament_id: tournament_id)
            players = (leaderboard?.results?.leaderboard) ?? [LeaderboardPlayer]()
        }
    }

    private func getFixtureListViewModel() -> FixtureListView.ViewModel {
        let vm_tournaments = viewModel.getPastTournaments(tournaments: tournaments)
        let season_name = "2023 US PGA Tour"
        let vm = FixtureListView.ViewModel(tournaments: vm_tournaments, season_name: season_name)
        return vm
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

        func getPastTournaments(tournaments: [Tournament]) -> [Tournament] {
            var pastTournaments = [Tournament]()
            for tournament in tournaments {
                if isDatePast(dateParam: tournament.end_date) {
                    pastTournaments.append(tournament)
                }
            }
            return pastTournaments
        }

        func getFixture() -> Fixture {
            return GolfDataService().getFixtures()
        }

        func isDatePast(dateParam: String) -> Bool {
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

            if let date = dateFormatter.date(from: dateParam) {
                if currentDate > date {
                    return true
                }
            }
            return false
        }
    }
}
