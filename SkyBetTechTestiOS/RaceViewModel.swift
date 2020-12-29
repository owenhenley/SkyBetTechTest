//
//  RaceViewModel.swift
//  SkyBetTechTestiOS
//
//  Created by Owen Henley on 26/12/2020.
//

import Foundation

class RaceViewModel {
    
    var service: HorseRacesServiceProtocol
    private let urlSession = URLSession.shared
    
    init(service: HorseRacesServiceProtocol = HorseRacesService()) {
        self.service = service
    }
    
    func fetchRaces(completion: @escaping (Result<[Race], Error>) -> Void) {
        service.fetchRaces(using: urlSession) { races, error in
            if let error = error {
                completion(.failure(error))
            } else if let races = races {
                completion(.success(races))
            } else {
                let error = NSError(domain: "sky", code: -1, userInfo: nil)
                completion(.failure(error))
            }
        }
    }
}
