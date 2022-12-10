
import SwiftUI

struct FixtureListView: View {
    @State private var fixture: Fixture?
    @State private var tournaments = [Tournament]()
    private var viewModel = ViewModel()
    private var currentDate = Date()
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(tournaments, id: \.id) { tournament in
                        if isDatePast(dateParam: tournament.end_date) {
                            NavigationLink(destination: HomeView(tour_id: tournament.id)) {
                                VStack(alignment: .leading) {
                                    Text("\(tournament.name)")
                                        .font(.headline)
                                    Text("\(getFormattedDate(dateString: tournament.start_date)) - \(getFormattedDate(dateString: tournament.end_date))")
                                }
                            }
                        }
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            fixture = self.viewModel.getFixture()
            tournaments = (fixture?.results) ?? [Tournament]()
        })
    }

    func getFormattedDate(dateString: String) -> String {
        let dateFormat = String(dateString.prefix(10))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatter.date(from: dateFormat) {
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let formattedDateString = dateFormatter.string(from: date)
            print(formattedDateString) // 12/10/2022
            return formattedDateString
        }
        return ""
    }

    func isDatePast(dateParam: String) -> Bool {
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

struct FixtureListView_Previews: PreviewProvider {
    static var previews: some View {
        FixtureListView()
    }
}

extension FixtureListView {
    private struct ViewModel {
        func getFixture() -> Fixture {
            return GolfDataService().getFixtures()
        }
    }
}
