//
//  RaceSummary.swift
//  SkyBetTechTestiOS
//

import Foundation

struct RaceSummary: Codable {
    let name: String
    let courseName: String
    let date: String

    private enum CodingKeys: String, CodingKey {
        case name
        case courseName = "course_name"
        case date
    }
}
