//
//  RaceTableViewCell.swift
//  SkyBetTechTestiOS
//

import UIKit

class RaceTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet var raceNameLabel: UILabel!
    @IBOutlet var courseNameLabel: UILabel!
    @IBOutlet var raceDateLabel: UILabel!

    // MARK: - Properties
    var race: Race? {
        didSet {
            updateViews()
        }
    }
    
    /// Update the cell's labels.
    private func updateViews() {
        guard let race = race else {
            print("Error: Race data not vaid.", #file, #function, #line)
            return
        }
        raceNameLabel.text = race.raceSummary.name
        courseNameLabel.text = race.raceSummary.courseName
        raceDateLabel.text = race.raceSummary.date
    }
}
