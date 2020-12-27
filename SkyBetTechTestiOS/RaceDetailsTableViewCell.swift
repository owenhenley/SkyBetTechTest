//
//  RaceDetailsTableViewCell.swift
//  SkyBetTechTestiOS
//

import UIKit

protocol PlaceBetProtocol: AnyObject {
    func placeBet(on ride: RideViewModel)
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
    
    var rideViewModel: RideViewModel? {
        didSet {
            updateViews()
        }
    }
    var betPlaced = false {
        didSet {
            updateViews()
        }
    }
    
    weak var betDelegate: PlaceBetProtocol!
    
    // MARK: - Methods
    
    /// Update the cell's labels.
    private func updateViews() {
        guard let ride = rideViewModel else {
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
            placeBetButton.backgroundColor = .red
        case false:
            placeBetButton.setTitle("Place Bet", for: .normal)
            placeBetButton.isEnabled = true
            placeBetButton.backgroundColor = .systemBlue
        }
    }
    
    // MARK: - Actions
    
    @IBAction func placeBet(_ sender: Any) {
        if let ride = rideViewModel {
            betDelegate.placeBet(on: ride)
        }
    }
}
