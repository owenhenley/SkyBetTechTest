//
//  RideViewModelTests.swift
//  SkyBetTechTestiOSTests
//
//  Created by Owen Henley on 29/12/2020.
//

import XCTest
@testable import SkyBetTechTestiOS

class RideViewModelTests: XCTestCase {
    
    var rideViewModel = RideViewModel(rides: [
        Ride(clothNumber: 1, formSummary: "22", currentOdds: "3/2"),
        Ride(clothNumber: 2, formSummary: "11", currentOdds: "4/1"),
        Ride(clothNumber: 3, formSummary: "33", currentOdds: "1/7")
    ])

    func testRideViewModel() {
        XCTAssertEqual(rideViewModel.sortedRides[0].clothNumber, 1)
        XCTAssertEqual(rideViewModel.sortedRides[0].formSummary, "22")
        XCTAssertEqual(rideViewModel.sortedRides[0].currentOdds, "3/2")
    }
    
    func testSortingClothNumber() {
        rideViewModel.sortOrder = .clothNumber
        XCTAssertEqual(rideViewModel.sortedRides[0].clothNumber, 1)
        XCTAssertEqual(rideViewModel.sortedRides[1].clothNumber, 2)
        XCTAssertEqual(rideViewModel.sortedRides[2].clothNumber, 3)
    }
    
    func testSortingFormSummary() {
        rideViewModel.sortOrder = .formSummary
        XCTAssertEqual(rideViewModel.sortedRides[0].clothNumber, 2)
        XCTAssertEqual(rideViewModel.sortedRides[1].clothNumber, 1)
        XCTAssertEqual(rideViewModel.sortedRides[2].clothNumber, 3)
    }
    
    func testSortingOdds() {
        rideViewModel.sortOrder = .odds
        XCTAssertEqual(rideViewModel.sortedRides[0].clothNumber, 3)
        XCTAssertEqual(rideViewModel.sortedRides[1].clothNumber, 1)
        XCTAssertEqual(rideViewModel.sortedRides[2].clothNumber, 2)
    }
}
