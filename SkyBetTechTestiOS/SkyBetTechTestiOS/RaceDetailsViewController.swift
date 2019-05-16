//
//  RaceDetailsViewController.swift
//  SkyBetTechTestiOS
//

import UIKit

class RaceDetailsViewController: UITableViewController {

    // MARK: - Properties
    var rides = [Ride]()

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
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rides.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "raceDetailsCell", for: indexPath) as? RaceDetailsTableViewCell else {
            print("Using default table view cell")
            return UITableViewCell()
        }

        cell.ride = rides[indexPath.row]
        
        return cell
    }
}
