import SwiftUI

struct PlayerCellView: View {
    var player: LeaderboardPlayer
    var body: some View {
        HStack {
            Text("\(player.position)").frame(width: 25)
                .frame(alignment: .leading)
            Text("\(countryFlag(from: player.country))")
            Text("\(player.first_name) \(player.last_name)")
            Spacer()
            Text(getScore(pScore: player.total_to_par))
                .frame(alignment: .leading)
        }
    }
}

func getScore(pScore: Int) -> String {
    var score = ""
    if pScore > 0 {
        score = "+" + String(pScore)
    } else {
        score = String(pScore)
    }
    return score
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
