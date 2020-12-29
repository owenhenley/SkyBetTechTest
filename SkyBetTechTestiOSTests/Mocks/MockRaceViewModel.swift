//
//  MockRaceViewModel.swift
//  SkyBetTechTestiOSTests
//
//  Created by Owen Henley on 29/12/2020.
//

import Foundation
@testable import SkyBetTechTestiOS

class MockRaceViewModel: RaceViewModel {
    
    var fetchWasCalled: Bool = false
    
    override func fetchRaces(completion: @escaping (Result<[Race], Error>) -> Void) {
        fetchWasCalled = true
    }
}
