import SwiftUI

struct CountryFlag: View {
    let countryCode: String

    var body: some View {
        Text(countryEmoji(from: countryCode))
            .font(.title)
    }

    func countryEmoji(from countryCode: String) -> String {
        // Extract the 2-letter country code from the 3-digit code
        let locale = Locale(identifier: "en_\(countryCode)")
        let country = locale.regionCode ?? "ZZ"

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
}

struct CountryFlag_Previews: PreviewProvider {
    static var previews: some View {
        CountryFlag(countryCode: "KOR")
    }
}
