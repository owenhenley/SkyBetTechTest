//
//  RaceTableViewCell.swift
//  SkyBetTechTestiOS
//

import UIKit

/// Cell class for the RacesViewController.
class RaceTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet var raceNameLabel: UILabel!
    @IBOutlet var courseNameLabel: UILabel!
    @IBOutlet var raceDateLabel: UILabel!

    // MARK: - Properties
    
    var raceViewModel: RaceViewModel? {
        didSet {
            updateViews()
        }
    }

    // MARK: - Methods

    /// Update the cell's labels.
    private func updateViews() {
        guard let raceViewModel = raceViewModel else {
            print("Error: Race data not valid.", #file, #function, #line)
            return
        }
        raceNameLabel.text = raceViewModel.raceNameText
        courseNameLabel.text = raceViewModel.courseNameText
        raceDateLabel.text = raceViewModel.dateText
    }
}
