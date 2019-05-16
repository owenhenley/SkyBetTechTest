//
//  RaceDetailsTableViewCell.swift
//  SkyBetTechTestiOS
//

import UIKit

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
    
    /// Update the cells labels.
    private func updateViews() {
        guard let ride = ride else {
            return
        }
        
        clothNumberLabel.text = "\(ride.clothNumber)"
        formSummaryLabel.text = ride.formSummary
        oddsLabel.text = ride.currentOdds
    }
}
