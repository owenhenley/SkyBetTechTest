//
//  RacesViewController.swift
//  SkyBetTechTestiOS
//

import UIKit

/// Class for the `Races` tableview screen.
class RacesViewController: BaseViewController {

    // MARK: - Views

    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)

    // MARK: - Properties

    private var raceDataSource = RaceDataSource()

    // MARK: - Lifecyle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigation()
        fetchRaces()
    }

    /// Fetch all race data.
    @objc private func fetchRaces() {
        handleActivityIndicator(activityIndicator)
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            NetworkController.shared.fetchRaces { races, error in
                if let error = error {
                    self?.showErrorAlert(error: error)
                    return
                }

                guard let races = races else { return }
                self?.raceDataSource.races = races

                self?.reloadDataOnMainThread()
            }


            DispatchQueue.main.async { [weak self] in
                self?.tableView.refreshControl?.endRefreshing()
                if let activityIndicator = self?.activityIndicator {
                    self?.handleActivityIndicator(activityIndicator)
                }
            }
        }
    }

    /// Setup the navigations options.
    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        navigationController?.toolbar.tintColor = .black
    }

    // MARK: - UITableView
    
    /// Setup the table view
    private func setupTableView() {
        let nib = UINib(nibName: "RaceTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "raceCell")
        tableView.dataSource = raceDataSource
        pullToRefresh()
    }

    /// Implements a pull to refesh feature to the `tableView`.
    private func pullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchRaces), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    /// Reload the table view's data on the main thread.
    private func reloadDataOnMainThread() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate
extension RacesViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = RaceDetailsViewController()
        if let rides = raceDataSource.races[indexPath.row].rides {
            detailsVC.rideDataSource.rides = rides

            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}
