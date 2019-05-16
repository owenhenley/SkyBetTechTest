//
//  Rides.swift
//  SkyBetTechTestiOS
//

import Foundation

/// An object for all Rider Data.
struct Rides: Codable {
    let clothNumber: Int
    let formSummary: String
    let currentOdds: String

    private enum CodingKeys: String, CodingKey {
        case clothNumber = "cloth_number"
        case formSummary = "formsummary"
        case currentOdds = "current_odds"
    }
}
