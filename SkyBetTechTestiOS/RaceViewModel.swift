//
//  RaceViewModel.swift
//  SkyBetTechTestiOS
//
//  Created by Owen Henley on 26/12/2020.
//

import UIKit

struct RaceViewModel {
    let service: HorseRacesService = HorseRacesService()
    
    func fetchRaces(completion: @escaping (Result<[Race], Error>) -> Void) {
        service.fetchRaces { races, error in
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
