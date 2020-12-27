//
//  Race.swift
//  SkyBetTechTestiOS
//

import Foundation

struct Race: Codable {
    let raceSummary: RaceSummary
    let rides: [Ride]

    private enum CodingKeys: String, CodingKey {
        case raceSummary = "race_summary"
        case rides
    }
}
