//
//  RideViewModelTests.swift
//  SkyBetTechTestiOSTests
//
//  Created by Owen Henley on 29/12/2020.
//

import XCTest
@testable import SkyBetTechTestiOS

class RideViewModelTests: XCTestCase {

    func testRideViewModel() {
        let rides: [Ride] = [
            Ride(clothNumber: 47, formSummary: "456789", currentOdds: "4/2"),
            Ride(clothNumber: 44, formSummary: "456789", currentOdds: "4/4")
        ]
        let rideViewModel = RideViewModel(rides: rides)
        
        XCTAssertEqual(rides.first?.clothNumber, rideViewModel.sortedRides.first?.clothNumber)
        XCTAssertEqual(rides.first?.currentOdds, rideViewModel.sortedRides.first?.currentOdds)
        XCTAssertEqual(rides.first?.formSummary, rideViewModel.sortedRides.first?.formSummary)
    }
    
    func testSortingClothNumber() {
        let rides: [Ride] = [
            Ride(clothNumber: 47, formSummary: "556789", currentOdds: "4/2"),
            Ride(clothNumber: 44, formSummary: "456789", currentOdds: "4/4")
        ]
        let rideViewModel = RideViewModel(rides: rides)
        let viewController = RaceDetailsViewController(viewModel: rideViewModel)
        viewController.sortClothNumber()
        
        XCTAssertEqual(rides.first?.clothNumber, rideViewModel.sortedRides.first?.clothNumber)
    }
    
    func testSortingFormSummary() {
        let rides: [Ride] = [
            Ride(clothNumber: 47, formSummary: "556789", currentOdds: "4/2"),
            Ride(clothNumber: 44, formSummary: "456789", currentOdds: "4/4")
        ]
        let rideViewModel = RideViewModel(rides: rides)
        let viewController = RaceDetailsViewController(viewModel: rideViewModel)
        viewController.sortFormSummary()
        
        XCTAssertEqual(rides.first?.formSummary, rideViewModel.sortedRides.first?.formSummary)
    }
    
    func testSortingOdds() {
        let rides: [Ride] = [
            Ride(clothNumber: 47, formSummary: "556789", currentOdds: "4/2"),
            Ride(clothNumber: 44, formSummary: "456789", currentOdds: "4/4")
        ]
        let rideViewModel = RideViewModel(rides: rides)
        let viewController = RaceDetailsViewController(viewModel: rideViewModel)
        viewController.sortOdds()
        
        XCTAssertEqual(rides.first?.currentOdds, rideViewModel.sortedRides.first?.currentOdds)
    }
}
