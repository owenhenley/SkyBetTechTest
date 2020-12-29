//
//  Rides.swift
//  SkyBetTechTestiOS
//

import Foundation

struct Ride: Codable {
    let clothNumber: Int
    let formSummary: String
    let currentOdds: String
    
    var sortableOdds: Double {
        let components = currentOdds.components(separatedBy: "/").map { Int($0) }
        guard components.count == 2,
              let num1 = components[0],
              let num2 = components[1],
              num2 != 0 else { return 0 }
        return Double(num1)/Double(num2)
    }


    private enum CodingKeys: String, CodingKey {
        case clothNumber = "cloth_number"
        case formSummary = "formsummary"
        case currentOdds = "current_odds"
    }
}
