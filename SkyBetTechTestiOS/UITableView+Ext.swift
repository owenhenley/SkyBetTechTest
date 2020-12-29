//
//  UITableView+Ext.swift
//  SkyBetTechTestiOS
//
//  Created by Owen Henley on 15/12/2020.
//

import UIKit

extension UITableViewController {
    func enablePullToRefresh(completion: (_ control: UIRefreshControl) -> Void) {
        let refreshControl = UIRefreshControl()
        completion(refreshControl)
        tableView.refreshControl = refreshControl
    }

    func reloadDataOnMainThread() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}
