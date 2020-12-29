//
//  RaceViewModelTests.swift
//  SkyBetTechTestiOSTests
//
//  Created by Owen Henley on 29/12/2020.
//

import XCTest
@testable import SkyBetTechTestiOS

class RaceViewModelTests: XCTestCase {
    
    func testRaceViewModel() {
        let viewModel = MockRaceViewModel()
        let viewController = RacesViewController(viewModel: viewModel)
        viewController.fetchRaces()
        
        XCTAssertTrue(viewModel.fetchWasCalled)
    }
}
