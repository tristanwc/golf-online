import SwiftUI

enum NineHoles {
    case front
    case back
}

struct ScorecardView: View {
    let viewModel: ViewModel
    // HOLE 1 2 3 4 5 6 7 8 9
    // -------------------------------
    // PAR
    // -------------------------------
    // R1
    // -------------------------------

    var body: some View {
        VStack(spacing: 0) {
            // MARK: Front 9 Scorecard

            HStack(spacing: 0) {
                Text("Hole").frame(width: 50, alignment: .leading)
                ForEach(viewModel.getNineHolesDetails(whichNine: .front), id: \.hole_num) { detail in
                    ZStack {
                        Rectangle().opacity(0.2)
                        Text(detail.hole_num)
                    }
                    .frame(width: 25, height: 20)
                }
                ZStack {
                    Rectangle().opacity(0.2)
                    Text("OUT")
                        .fixedSize(horizontal: false, vertical: false)
                }
                .frame(width: 40, height: 20)
                Rectangle().opacity(0.2)
                    .frame(width: 40, height: 20)
            }
            HStack(spacing: 0) {
                Text("Par").frame(width: 50, alignment: .leading)
                ForEach(viewModel.getNineHolesDetails(whichNine: .front), id: \.hole_num) { detail in
                    ZStack {
                        Rectangle().opacity(0.1)
                        Text(detail.par)
                    }
                    .frame(width: 25, height: 20)
                }
                ZStack {
                    Rectangle().opacity(0.1)
                    Text("\(viewModel.getNinePar(whichNine: .front))")
                }
                .frame(width: 40, height: 20)
                Rectangle().opacity(0.1)
                    .frame(width: 40, height: 20)
            }
            HStack(spacing: 0) {
                Text("Score").frame(width: 50, alignment: .leading)
                ForEach(viewModel.getNineHoleScores(whichNine: .front), id: \.hole_number) { score in
                    ZStack {
                        Rectangle().opacity(0.1)
                        Text(score.score)
                    }
                    .frame(width: 25, height: 20)
                }
                ZStack {
                    Rectangle().opacity(0.1)
                    Text("\(viewModel.getTotalNineScores(whichNine: .front))")
                }
                .frame(width: 40, height: 20)
                Rectangle().opacity(0.1)
                    .frame(width: 40, height: 20)
            }

            // MARK: Back 9 Scorecard

            Divider().frame(width: 355, height: 3).overlay(.black)

            HStack(spacing: 0) {
                Text("Hole").frame(width: 50, alignment: .leading)
                ForEach(viewModel.getNineHolesDetails(whichNine: .back), id: \.hole_num) { detail in
                    ZStack {
                        Rectangle().opacity(0.2)
                        Text(detail.hole_num)
                    }
                    .frame(width: 25, height: 20)
                }
                ZStack {
                    Rectangle().opacity(0.2)
                    Text("IN")
                }
                .frame(width: 40, height: 20)
                ZStack {
                    Rectangle().opacity(0.2)
                    Text("TOT")
                }
                .frame(width: 40, height: 20)
            }
            HStack(spacing: 0) {
                Text("Par").frame(width: 50, alignment: .leading)
                ForEach(viewModel.getNineHolesDetails(whichNine: .back), id: \.hole_num) { detail in
                    ZStack {
                        Rectangle().opacity(0.1)
                        Text(detail.par)
                    }
                    .frame(width: 25, height: 20)
                }
                ZStack {
                    Rectangle().opacity(0.1)
                    Text("\(viewModel.getNinePar(whichNine: .back))")
                }
                .frame(width: 40, height: 20)
                ZStack {
                    Rectangle().opacity(0.1)
                    Text("\(viewModel.getParTotal())")
                }
                .frame(width: 40, height: 20)
            }
            HStack(spacing: 0) {
                Text("Score").frame(width: 50, alignment: .leading)
                ForEach(viewModel.getNineHoleScores(whichNine: .back), id: \.hole_number) { score in
                    ZStack {
                        Rectangle().opacity(0.1)
                        Text(score.score)
                    }
                    .frame(width: 25, height: 20)
                }
                ZStack {
                    Rectangle().opacity(0.1)
                    Text("\(viewModel.getTotalNineScores(whichNine: .back))")
                }
                .frame(width: 40, height: 20)
                ZStack {
                    Rectangle().opacity(0.1)
                    Text("\(viewModel.getTotalScore())")
                }
                .frame(width: 40, height: 20)
            }
        }
    }
}

extension ScorecardView {
    struct ViewModel {
        var roundNumber: Int
        var courseData: CourseData?
        var holeDetails: [HoleDetail]?
        var holeScores: [HoleScore]?

        func getTotalScore() -> Int {
            let frontScore = getTotalNineScores(whichNine: .front)
            let backScore = getTotalNineScores(whichNine: .back)
            return (frontScore + backScore)
        }

        func getNineHolesDetails(whichNine: NineHoles) -> [HoleDetail] {
            if let holeDetails = holeDetails {
                switch whichNine {
                case .front:
                    return Array(holeDetails.prefix(9))
                case .back:
                    return Array(holeDetails.suffix(9))
                }
            }

            return [HoleDetail]()
        }

        func getNineHoleScores(whichNine: NineHoles) -> [HoleScore] {
            if let holeScores = holeScores {
                switch whichNine {
                case .front:
                    return Array(holeScores.prefix(9))
                case .back:
                    return Array(holeScores.suffix(9))
                }
            }
            return [HoleScore]()
        }

        func getTotalNineScores(whichNine: NineHoles) -> Int {
            var totalScore = 0
            let nineScores = getNineHoleScores(whichNine: whichNine)
            for score in nineScores {
                totalScore += Int(score.score)!
            }
            return totalScore
        }

        func getNinePar(whichNine: NineHoles) -> Int {
            switch whichNine {
            case .front:
                return courseData?.par_front ?? 0
            case .back:
                return courseData?.par_back ?? 0
            }
        }

        func getParTotal() -> Int {
            let frontPar = courseData?.par_front ?? 0
            let backPar = courseData?.par_back ?? 0
            return (frontPar + backPar)
        }
    }
}
