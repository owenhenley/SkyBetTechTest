//
//  RaceTableViewCell.swift
//  SkyBetTechTestiOS
//

import UIKit

class RaceTableViewCell: UITableViewCell {

    @IBOutlet var raceNameLabel: UILabel!
    @IBOutlet var courseNameLabel: UILabel!
    @IBOutlet var raceDateLabel: UILabel!

    var race: Race? {
        didSet {
            updateViews()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    /// <#Description#>
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
