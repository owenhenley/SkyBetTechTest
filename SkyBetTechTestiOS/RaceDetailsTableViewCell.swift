//
//  RaceDetailsTableViewCell.swift
//  SkyBetTechTestiOS
//

import UIKit
import LocalAuthentication

protocol BetAlertProtocol: AnyObject {
    func showAlert(error: Error?, message: String, actions: [UIAlertAction]?)
}

/// Cell class for the RaceDetailsViewController.
class RaceDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet var clothNumberLabel: UILabel!
    @IBOutlet var formSummaryLabel: UILabel!
    @IBOutlet var oddsLabel: UILabel!
    @IBOutlet var placeBetButton: UIButton! {
        didSet {
            placeBetButton.setTitle("Place Bet", for: .normal)
            placeBetButton.layer.cornerRadius = 3
        }
    }
    
    var ride: Ride? {
        didSet {
            updateViews()
        }
    }
    
    weak var alertDelegate: BetAlertProtocol!
    
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
    
    // MARK: - Actions
    
    @IBAction func placeBet(_ sender: Any) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: "Security check") { [weak self] success, authenticationError in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if success {
                        // Show success
                        
                        
                        let goToSettings = UIAlertAction(title: "Settings", style: .default) { _ in
                            self.goToDeviceSettings()
                        }
                        
                        self.alertDelegate.showAlert(error: nil, message: "You need to allow access to FaceID/TouchID to place a bet.", actions: [goToSettings])
                    } else {
                        // error
                    }
                }
            }
        } else {
            goToDeviceSettings()
        }
    }
    
    @objc private func goToDeviceSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl)
        }
    }
    
    
}
