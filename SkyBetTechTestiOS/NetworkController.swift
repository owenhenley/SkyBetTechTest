//
//  NetworkController.swift
//  SkyBetTechTestiOS
//

import Foundation

/// Class to make all network calls.
class NetworkController {

    // MARK: - Properties

    // Get the base url from a plist. (It has my name in the url...)
    private var baseURL: String {
        let filePath = Bundle.main.path(forResource: "BaseURL", ofType: "plist")
        let plist = NSDictionary(contentsOfFile:filePath!)
        let value = plist?.object(forKey: "baseURL") as! String
        return value
    }

    // MARK: - Methods
    
    /// Fetch all race data.
    ///
    /// - Parameter completion: A closure for handling the returned data.
    func fetchRaces(completion: @escaping ([Race]?, Error?) -> Void) {
        // URL
        guard var url = URL(string: baseURL) else { return }
        url.appendPathComponent("SkyBetTechTest")
        url.appendPathComponent("techtest")
        url.appendPathExtension("json")

        // Request
        let request = URLRequest(url: url, method: .get)

        // Fetch data
        URLSession.shared.dataTask(with: request) { (data, response, error) in
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
