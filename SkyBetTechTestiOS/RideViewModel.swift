//
//  RideViewModel.swift
//  SkyBetTechTestiOS
//
//  Created by Owen Henley on 26/12/2020.
//

import UIKit

struct RideViewModel {
    private let rides: [Ride]
    var sortOrder: SortOrder = .none
    
    var sortedRides: [Ride] {
        switch sortOrder {
        case .none:
            return rides
        case .clothNumber:
            return rides.sorted { $0.clothNumber < $1.clothNumber }
        case .formSummary:
            return rides.sorted { $0.formSummary < $1.formSummary }
        case .odds:
            return rides.sorted { $0.sortableOdds < $1.sortableOdds }
        }
    }
    
    init(rides: [Ride]) {
        self.rides = rides
    }
}

enum SortOrder {
    case clothNumber
    case formSummary
    case odds
    case none
}
