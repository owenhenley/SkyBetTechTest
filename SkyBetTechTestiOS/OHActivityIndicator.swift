//
//  OHActivityIndicator.swift
//  SkyBetTechTestiOS
//
//  Created by Owen Henley on 27/05/2019.
//

import UIKit

class OHActivityIndicator {

    private static var activityIndicator: UIActivityIndicatorView?
    private static var style: UIActivityIndicatorView.Style = .whiteLarge
    private static var color: UIColor = .black

    static func start(for view: UIView, style: UIActivityIndicatorView.Style = style, color: UIColor = color) {
        guard activityIndicator == nil else {
            return
        }

        // Setup
        let spinner = UIActivityIndicatorView()

        // Style
        spinner.style = style
        spinner.color = color

        // Layout
        view.addSubview(spinner)

        spinner.centerInSuperview()

        activityIndicator = spinner
        activityIndicator?.startAnimating()
    }

    static func stop() {
        DispatchQueue.main.async {
            activityIndicator?.stopAnimating()
            activityIndicator?.removeFromSuperview()
            activityIndicator = nil
        }
    }
}
