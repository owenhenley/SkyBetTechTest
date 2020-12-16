//
//  OHActivityIndicator.swift
//  SkyBetTechTestiOS
//
//  Created by Owen Henley on 27/05/2019.
//

import UIKit

class ActivityIndicator: UIActivityIndicatorView {

    private static var activityIndicator: UIActivityIndicatorView?
    private static var style: UIActivityIndicatorView.Style = .whiteLarge
    private static var color: UIColor = .blue
    private static var backgroundView: UIView?

    static func start(for view: UIView, style: UIActivityIndicatorView.Style = style, color: UIColor = color) {
        guard activityIndicator == nil else {
            return
        }

        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.style = style
        spinner.color = color
        
        let backgroundView = UIView()
        self.backgroundView = backgroundView
        backgroundView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(backgroundView)
        backgroundView.addSubview(spinner)
        backgroundView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        backgroundView.layer.borderColor = UIColor.darkGray.cgColor
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.cornerRadius = 10

        NSLayoutConstraint.activate([
            backgroundView.heightAnchor.constraint(equalToConstant: 70),
            backgroundView.widthAnchor.constraint(equalToConstant: 70),
            backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
        ])
        activityIndicator = spinner
        activityIndicator?.startAnimating()
    }

    static func stop() {
        DispatchQueue.main.async {
            backgroundView?.removeFromSuperview()
            activityIndicator?.stopAnimating()
            backgroundView = nil
            activityIndicator = nil
        }
    }
}
