//
//  ErrorAlert.swift
//  SkyBetTechTestiOS
//
//  Created by Owen Henley on 15/12/2020.
//

import UIKit

class ErrorAlert: NSObject {
    class func show(error: Error?, on view: UIViewController, message: String = "") {
        if let error = error {
            DispatchQueue.main.async {
                let ac = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                view.present(ac, animated: true)
            }
        } else {
            DispatchQueue.main.async {
                let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                view.present(ac, animated: true)
            }
        }
    }
}
