//
//  RaceViewModelTests.swift
//  SkyBetTechTestiOSTests
//
//  Created by Owen Henley on 29/12/2020.
//

import XCTest
@testable import SkyBetTechTestiOS

class RaceViewModelTests: XCTestCase {
    
    func testFetchSuccess() {
        let mockService = MockService(shouldSucceed: true)
        let raceViewModel = RaceViewModel(service: mockService)
        let fetchExpectation = expectation(description: "fetch")
        raceViewModel.fetchRaces { result in
            switch result {
            case .success:
                fetchExpectation.fulfill()
            case .failure:
                XCTFail("should've succeeded")
            }
        }
        wait(for: [fetchExpectation], timeout: 10)
    }
    
    func testFetchError() {
        let mockService = MockService(shouldSucceed: false)
        let raceViewModel = RaceViewModel(service: mockService)
        let fetchExpectation = expectation(description: "fetch")
        raceViewModel.fetchRaces { result in
            switch result {
            case .success:
                XCTFail("should've failed")
            case .failure:
                fetchExpectation.fulfill()
            }
        }
        wait(for: [fetchExpectation], timeout: 10)
    }
}
