//
//  HorseRacesService.swift
//  SkyBetTechTestiOS
//

import Foundation

protocol URLSessionProtocol {
   func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

protocol HorseRacesServiceProtocol {
    func fetchRaces(using session: URLSessionProtocol, completion: @escaping ([Race]?, Error?) -> Void)
}

/// Class to make all network calls.
class HorseRacesService: HorseRacesServiceProtocol {

    // Get the base url from a plist.
    private var baseURL: String {
        let filePath = Bundle.main.path(forResource: "BaseURL", ofType: "plist")
        let plist = NSDictionary(contentsOfFile:filePath!)
        let value = plist?.object(forKey: "baseURL") as! String
        return value
    }
    
    /// Fetch all race data.
    ///
    /// - Parameter completion: handle the returned data.
    func fetchRaces(using session: URLSessionProtocol =
                        URLSession.shared, completion: @escaping ([Race]?, Error?) -> Void) {
        // URL
        guard var url = URL(string: baseURL) else { return }
        url.appendPathComponent("SkyBetTechTest")
        url.appendPathComponent("main")
        url.appendPathComponent("techtest")
        url.appendPathExtension("json")

        // Request
        let request = URLRequest(url: url, method: .get)

        // Fetch data
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(#file), \(#function), \(#line), Message: \(error). \(error.localizedDescription)")
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, nil)
                print("Error: Data is invalid", #file, #function, #line)
                return
            }

            let jsonDecoder = JSONDecoder()
            do {
                let races = try jsonDecoder.decode([Race].self, from: data)
                completion(races, nil)
            } catch {
                print("Error: \(#file), \(#function), \(#line), Message: \(error). \(error.localizedDescription)")
            }
        }.resume()
    }
}
