//
//  RaceDetailsViewController.swift
//  SkyBetTechTestiOS
//

import UIKit

class RaceDetailsViewController: UITableViewController {

    // MARK: - Properties
    var rideDataSource = RaceDetailsDataSource()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigation()
    }

    // MARK: - Methods
    /// Setup the navigation options.
    private func setupNavigation() {
        title = "Race Details"
        navigationItem.largeTitleDisplayMode = .never
    }

    // MARK: - UITableView
    /// Setup the table view.
    private func setupTableView() {
        let nib = UINib(nibName: "RaceDetailsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "raceDetailsCell")
        tableView.dataSource = rideDataSource
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
