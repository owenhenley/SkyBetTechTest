//
//  AlertTests.swift
//  SkyBetTechTestiOSTests
//
//  Created by Owen Henley on 29/12/2020.
//

import XCTest
@testable import SkyBetTechTestiOS

class AlertTests: XCTestCase {
    
    func testShowAlert() {
        let alert = Alert()
        let vc = RacesViewController(viewModel: RaceViewModel())
        UIApplication.shared.keyWindow?.rootViewController = vc
        
        let exp = expectation(description: "testAlert")
        alert.show(error: nil, on: vc, title: "hello", message: "test") {
            exp.fulfill()
        }
        waitForExpectations(timeout: 2)
    }
    
    func testShowErrorAlert() {
        let alert = Alert()
        let vc = RacesViewController(viewModel: RaceViewModel())
        UIApplication.shared.keyWindow?.rootViewController = vc
        
        let exp = expectation(description: "testAlert")
        alert.show(error: NSError(domain: "sky", code: -1, userInfo: nil), on: vc, title: "hello", message: "test") {
            exp.fulfill()
        }
        waitForExpectations(timeout: 2)
    }
}
