//
//  NetworkController.swift
//  SkyBetTechTestiOS
//

import Foundation

class NetworkController {

    // MARK: - Singleton
    static let shared = NetworkController()

    // MARK: - Properties
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
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = nil

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
