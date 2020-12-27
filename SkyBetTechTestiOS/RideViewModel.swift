//
//  RideViewModel.swift
//  SkyBetTechTestiOS
//
//  Created by Owen Henley on 26/12/2020.
//

import UIKit

struct RideViewModel {
    var model: Ride
    var clothNumber: Int
    var formSummary: String
    var currentOdds: String
    
    init(ride: Ride) {
        self.model = ride
        self.clothNumber = ride.clothNumber
        self.formSummary = ride.formSummary
        self.currentOdds = ride.currentOdds
    }
    
    var number: Int {
        model.clothNumber
    }
    
//    mutating func updateRides(_ rides: [Ride]) -> RideViewModel {
//        model = rides.map({return RideViewModel(ride: $0)})
//    }
}
