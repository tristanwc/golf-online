import Foundation

class GolfDataService {
    let headers = [
        "X-RapidAPI-Key": "688a62ebccmsh42297fefd0d91e1p1bf74fjsn5e20ae8c5e3c",
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
            return "leaderboard/484"
        case .Scorecard:
            return "scorecard/484/"
        }
    }

    func getScorecard(player_id: Int) -> PGAScorecard {
        // Appends api url with specific service (world rankings, tours, project pga rankings, etc)
        let finalUrl = url + getService(value: .Scorecard) + String(player_id)
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

    func getLeaderboard() -> Leaderboard {
        // Appends api url with specific service (world rankings, tours, project pga rankings, etc)
        let finalUrl = url + getService(value: .Leaderboard)
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
