//
//  ErrorAlert.swift
//  SkyBetTechTestiOS
//
//  Created by Owen Henley on 15/12/2020.
//

import UIKit

class Alert: NSObject {
    
    func show(error: Error?, on view: UIViewController, title: String, message: String, actions: [UIAlertAction]? = nil) {
        if let error = error {
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: "Error",
                                                        message: "\(error.localizedDescription)",
                                                        preferredStyle: .alert)
                self.addActions(actions: actions, to: alertController)
                view.present(alertController, animated: true)
            }
        } else {
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: title,
                                                        message: message,
                                                        preferredStyle: .alert)
                self.addActions(actions: actions, to: alertController)
                view.present(alertController, animated: true)
            }
        }
    }
    
    // MARK: - Helpers
    
    private func addActions(actions: [UIAlertAction]?, to alertController: UIAlertController) {
        if actions == nil {
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okAction)
        } else {
            actions?.forEach({ action in
                alertController.addAction(action)
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(cancelAction)
        }
    }
}
