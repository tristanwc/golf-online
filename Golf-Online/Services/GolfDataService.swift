import Foundation

enum Service {
    case WorldRankings
    case Tours
    case Leaderboard
    case Scorecard
    case ProjectedRankings
    case Fixtures
}

class GolfDataService {
    let headers = [
        "X-RapidAPI-Key": "7456191bf0msh390f009521c6abfp1ddd3fjsn1ed7f70527b7",
        "X-RapidAPI-Host": "golf-leaderboard-data.p.rapidapi.com"
    ]

    let url = "https://golf-leaderboard-data.p.rapidapi.com/"

    func getService(value: Service) -> String {
        switch value {
        case .WorldRankings:
            return "world-rankings"
        case .Tours:
            return "tours"
        case .Leaderboard:
            return "leaderboard/"
        case .Scorecard:
            return "scorecard/"
        case .ProjectedRankings:
            return "projected-rankings-pga/2023"
        case .Fixtures:
            return "fixtures/2/2023"
        }
    }

    func getFixtures() -> Fixture {
        // Appends api url with specific service (world rankings, tours, project pga rankings, etc)
        let finalUrl = url + getService(value: .Fixtures)
        let request = NSMutableURLRequest(url: NSURL(string: finalUrl)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()

        var result = Fixture()
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, _, error in
            if let error = error {
                print(error)
                dispatchGroup.leave()
                return
            }
            guard let data = data else {
                print("Failed to retrieve data")
                dispatchGroup.leave()
                return
            }

            do {
                let decoder = JSONDecoder()
                let initial = try decoder.decode(Fixture.self, from: data)
                result = initial

                dispatchGroup.leave()
            } catch let error as NSError {
                print(error)
                dispatchGroup.leave()
            }
        })

        dataTask.resume()
        dispatchGroup.wait()
        return result
    }

    func getProjectedRanking() -> PGAProjectedRanking {
        // Appends api url with specific service (world rankings, tours, project pga rankings, etc)
        let finalUrl = url + getService(value: .ProjectedRankings)
        let request = NSMutableURLRequest(url: NSURL(string: finalUrl)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()

        var result = PGAProjectedRanking()
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, _, error in
            if let error = error {
                print(error)
                dispatchGroup.leave()
                return
            }
            guard let data = data else {
                print("Failed to retrieve data")
                dispatchGroup.leave()
                return
            }

            do {
                let decoder = JSONDecoder()
                let initial = try decoder.decode(PGAProjectedRanking.self, from: data)
                result = initial

                dispatchGroup.leave()
            } catch let error as NSError {
                print(error)
                dispatchGroup.leave()
            }
        })

        dataTask.resume()
        dispatchGroup.wait()
        return result
    }

    func getScorecard(tournament_id: Int, player_id: Int) -> PGAScorecard {
        // Appends api url with specific service (world rankings, tours, project pga rankings, etc)
        let finalUrl = url + getService(value: .Scorecard) + String(tournament_id) + "/" + String(player_id)
        let request = NSMutableURLRequest(url: NSURL(string: finalUrl)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()

        var result = PGAScorecard()
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, _, error in
            if let error = error {
                print(error)
                dispatchGroup.leave()
                return
            }
            guard let data = data else {
                print("Failed to retrieve data")
                dispatchGroup.leave()
                return
            }
            do {
                let decoder = JSONDecoder()
                let initial = try decoder.decode(PGAScorecard.self, from: data)
                result = initial

                dispatchGroup.leave()
            } catch let error as NSError {
                print(error)
                dispatchGroup.leave()
            }
        })
        dataTask.resume()
        dispatchGroup.wait()
        return result
    }

    func getLeaderboard(tournament_id: Int) -> Leaderboard {
        // Appends api url with specific service (world rankings, tours, project pga rankings, etc)
        let finalUrl = "\(url)\(getService(value: .Leaderboard))\(tournament_id)"
        print(finalUrl)
        let request = NSMutableURLRequest(url: NSURL(string: finalUrl)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()

        var result = Leaderboard()
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, _, error in
            if let error = error {
                print(error)
                dispatchGroup.leave()
                return
            }
            guard let data = data else {
                print("Failed to retrieve data")
                dispatchGroup.leave()
                return
            }

            do {
                let decoder = JSONDecoder()
                let initial = try decoder.decode(Leaderboard.self, from: data)
                result = initial

                dispatchGroup.leave()
            } catch let error as NSError {
                print(error)
                dispatchGroup.leave()
            }
        })

        dataTask.resume()
        dispatchGroup.wait()
        return result
    }

    func getWorldRanking() -> WorldRanking {
        // Appends api url with specific service (world rankings, tours, project pga rankings, etc)
        let finalUrl = url + getService(value: .WorldRankings)
        let request = NSMutableURLRequest(url: NSURL(string: finalUrl)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()

        var result = WorldRanking()
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, _, error in
            if let error = error {
                print(error)
                dispatchGroup.leave()
                return
            }
            guard let data = data else {
                print("Failed to retrieve data")
                dispatchGroup.leave()
                return
            }

            do {
                let decoder = JSONDecoder()
                let initial = try decoder.decode(WorldRanking.self, from: data)
                result = initial

                dispatchGroup.leave()
            } catch let error as NSError {
                print(error)
                dispatchGroup.leave()
            }
        })

        dataTask.resume()
        dispatchGroup.wait()
        return result
    }
}
