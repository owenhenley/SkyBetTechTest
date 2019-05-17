//
//  RaceDetailsViewController.swift
//  SkyBetTechTestiOS
//

import UIKit
import SafariServices

class RaceDetailsViewController: BaseViewController {

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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: "https://m.skybet.com/horse-racing") else {
            print("There is an issue with the url.", #file, #function, #line)
            return
        }
        let svc = SFSafariViewController(url: url)
        self.present(svc, animated: true, completion: nil)
    }
}
