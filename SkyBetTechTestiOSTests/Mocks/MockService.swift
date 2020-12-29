//
//  MockService.swift
//  SkyBetTechTestiOSTests
//
//  Created by Owen Henley on 29/12/2020.
//

import Foundation
@testable import SkyBetTechTestiOS

struct MockService: HorseRacesServiceProtocol {
    
    let shouldSucceed: Bool
    
    func fetchRaces(using session: URLSessionProtocol, completion: @escaping ([Race]?, Error?) -> Void) {
        if shouldSucceed {
            completion([], nil)
        } else {
            let error = NSError(domain: "sky", code: -1, userInfo: nil)
            completion(nil, error)
        }
    }
}
