
import SwiftUI

struct FixtureView: View {
    var body: some View {
        Text("Hello World")
    }
}

extension FixtureView {
    struct ViewModel {
        var name: String
        var start_date: String
        var end_date: String
    }
}
