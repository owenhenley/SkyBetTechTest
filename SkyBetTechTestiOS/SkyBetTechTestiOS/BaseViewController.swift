//
//  BaseViewController.swift
//  SkyBetTechTestiOS
//
//  Created by Owen Henley on 17/05/2019.
//

import UIKit

class BaseViewController: UITableViewController {

    /// Show or hide an activity indicatior in the center of the screen.
    ///
    /// - Parameter activityIndicatior: The `UIActivityIndicatorView` you wish to handle.
    func handleActivityIndicator(_ activityIndicator: UIActivityIndicatorView) {
        DispatchQueue.main.async {
            if activityIndicator.isAnimating {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            } else {
                activityIndicator.color = .black
                activityIndicator.startAnimating()
                activityIndicator.hidesWhenStopped = true
                self.view.addSubview(activityIndicator)
                activityIndicator.centerInSuperview()
            }
        }
    }

    /// Show an alert displaying an error.
    ///
    /// - Parameter error: The error to display.
    func showErrorAlert(error: Error?, message: String = "") {
        if let error = error {
            DispatchQueue.main.async { [weak self] in
                let ac = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(ac, animated: true)
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(ac, animated: true)
            }
        }
    }

}
