//
//  RaceDetailsTableViewCell.swift
//  SkyBetTechTestiOS
//

import UIKit

protocol PlaceBetProtocol: AnyObject {
    func placeBet()
}

/// Cell class for the RaceDetailsViewController.
class RaceDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet var clothNumberLabel: UILabel!
    @IBOutlet var formSummaryLabel: UILabel!
    @IBOutlet var oddsLabel: UILabel!
    @IBOutlet var placeBetButton: UIButton! {
        didSet {
            placeBetButton.layer.cornerRadius = 3
        }
    }
    
    var ride: Ride? {
        didSet {
            updateViews()
        }
    }
    
    weak var betDelegate: PlaceBetProtocol!
    var betPlaced = false
    
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
        
        switch betPlaced {
        case true:
            placeBetButton.setTitle("Bet Placed", for: .disabled)
            placeBetButton.isEnabled = false
        case false:
            placeBetButton.setTitle("Place Bet", for: .normal)
            placeBetButton.isEnabled = true
        }
    }
    
    // MARK: - Actions
    
    @IBAction func placeBet(_ sender: Any) {
        betDelegate.placeBet()
    }
}
