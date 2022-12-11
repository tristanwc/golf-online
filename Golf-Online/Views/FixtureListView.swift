
import SwiftUI

struct FixtureListView: View {
    @Binding var tournament_id: Int
    @Binding var showingTournaments: Bool
    let viewModel: ViewModel
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.tournaments, id: \.id) { tournament in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(tournament.name)")
                                    .font(.headline)
                                Text("\(tournament.course)")
                                Text("\(tournament.country)")
                                Text("\(getFormattedDate(dateString: tournament.start_date)) - \(getFormattedDate(dateString: tournament.end_date))")
                                Text("\(getFormattedPrizeFund(prize_fund: tournament.prize_fund, fund_currency: tournament.fund_currency))")
                            }
                            Spacer()
                            Image(systemName: "arrow.right")
                                .font(.title).frame(alignment: .trailing)
                        }
                        .onTapGesture {
                            self.tournament_id = tournament.id
                            self.showingTournaments = false
                        }
                    }
                }
            }
            .navigationTitle(viewModel.season_name)
        }
        .edgesIgnoringSafeArea(.all)
    }

    func getFormattedPrizeFund(prize_fund: String, fund_currency: String) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        let formattedNumber = numberFormatter.string(from: NSNumber(value: Int(prize_fund) ?? 0)) ?? prize_fund
        if formattedNumber == "0" {
            return "Charity Tournament"
        }
        return "\(formattedNumber) \(fund_currency)"
    }

    func getFormattedDate(dateString: String) -> String {
        let dateFormat = String(dateString.prefix(10))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatter.date(from: dateFormat) {
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let formattedDateString = dateFormatter.string(from: date)
            return formattedDateString
        }
        return ""
    }
}

extension FixtureListView {
    struct ViewModel {
        var tournaments: [Tournament]
        var season_name: String
    }
}
