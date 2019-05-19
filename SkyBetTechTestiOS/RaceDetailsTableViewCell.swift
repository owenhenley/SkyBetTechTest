//
//  RaceDetailsTableViewCell.swift
//  SkyBetTechTestiOS
//

import UIKit

/// Cell class for the RaceDetailsViewController.
class RaceDetailsTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet var clothNumberLabel: UILabel!
    @IBOutlet var formSummaryLabel: UILabel!
    @IBOutlet var oddsLabel: UILabel!

    // MARK: - Properties

    var ride: Ride? {
        didSet {
            updateViews()
        }
    }

    // MARK: - Methods
    
    /// Update the cell's labels.
    private func updateViews() {
        guard let ride = ride else {
            print("Error: Ride data not valid.", #file, #function, #line)
            return
        }
        
        clothNumberLabel.text = "\(ride.clothNumber)"
        formSummaryLabel.text = ride.formSummary
        oddsLabel.text = ride.currentOdds
    }
}
