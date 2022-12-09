import SwiftSoup
import SwiftUI

struct HomeView: View {
    @State private var leaderboard: Leaderboard?
    @State private var players = [LeaderboardPlayer]()
    private var viewModel = ViewModel()
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    Text("\(leaderboard?.results?.tournament.name ?? "EROR_TOURNAMENT_TITLE")")
                        .font(.title)
                    List {
                        ForEach(players, id: \.player_id) { player in
                            if player.position < 10 {
                                Text(verbatim: "\(player.position)  \(countryFlag(from: player.country)) \(player.first_name) \(player.last_name), Score: \(player.total_to_par)")
                            } else {
                                Text(verbatim: "\(player.position) \(countryFlag(from: player.country)) \(player.first_name) \(player.last_name), Score: \(player.total_to_par)")
                            }
                        }
                    }
                }
            }
        }
        .onAppear(perform: {
            leaderboard = self.viewModel.getLeaderboard()
            players = (leaderboard?.results?.leaderboard)!
        })
    }
}



func countryFlag(from countryCode: String) -> String {
    // Extract the 2-letter country code from the 3-digit code
    var code = countryCode
    if countryCode == "ENG" { // England is glitchy
        code = "GB"
    }
    let locale = Locale(identifier: "en_\(code)")
    let country = locale.language.region?.identifier ?? "ZZ"

    // Construct the emoji string from the 2-letter country code
    let base: UInt32 = 127397
    var usv = String.UnicodeScalarView()
    for i in country.unicodeScalars {
        if CharacterSet.uppercaseLetters.contains(i) {
            usv.append(UnicodeScalar(base + i.value)!)
        }
    }
    return String(usv)
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
