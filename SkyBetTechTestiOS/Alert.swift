//
//  ErrorAlert.swift
//  SkyBetTechTestiOS
//
//  Created by Owen Henley on 15/12/2020.
//

import UIKit

class Alert: NSObject {
    class func show(error: Error?, on view: UIViewController, message: String = "", actions: [UIAlertAction]? = nil) {
        if let error = error {
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: "Error",
                                                        message: "\(error.localizedDescription)",
                                                        preferredStyle: .alert)
                addActions(actions: actions, to: alertController)
                view.present(alertController, animated: true)
            }
        } else {
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: "Something's Wrong",
                                                        message: message,
                                                        preferredStyle: .alert)
                addActions(actions: actions, to: alertController)
                view.present(alertController, animated: true)
            }
        }
    }
    
    // MARK: - Helpers
    
    private class func addActions(actions: [UIAlertAction]?, to alertController: UIAlertController) {
        if actions == nil {
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
        } else {
            actions?.forEach({ action in
                alertController.addAction(action)
            })
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        }
    }
}
