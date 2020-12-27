//
//  RaceViewModel.swift
//  SkyBetTechTestiOS
//
//  Created by Owen Henley on 26/12/2020.
//

import UIKit

struct RaceViewModel {
    let model: Race
    let raceNameText: String
    let courseNameText: String
    let dateText: String
    
    init(race: Race) {
        self.model = race
        self.raceNameText = model.raceSummary.name
        self.courseNameText = model.raceSummary.courseName
        self.dateText = model.raceSummary.date
    }
    
    func rides() -> [Ride]? {
        model.rides
    }
    
//    func raceSummery() -> RaceSummary {
//        model.raceSummary
//    }
}
