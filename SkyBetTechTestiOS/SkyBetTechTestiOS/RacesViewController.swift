//
//  RacesViewController.swift
//  SkyBetTechTestiOS
//

import UIKit

class RacesViewController: UITableViewController {

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
    private func fetchRaces() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            NetworkController.shared.fetchRaces { races, error in
                if let error = error {
                    self?.showErrorAlert(for: error)
                    return
                }

                guard let races = races else { return }
                self?.raceDataSource.races = races

                self?.reloadDataOnMainThread()
            }
        }
    }

    /// Setup the navigations options.
    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    /// Show an alert displaying an error.
    ///
    /// - Parameter error: The error to display.
    private func showErrorAlert(for error: Error) {
        DispatchQueue.main.async { [weak self] in
            let ac = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(ac, animated: true)
        }
    }

    // MARK: - UITableView
    /// Setup the table view
    private func setupTableView() {
        let nib = UINib(nibName: "RaceTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "raceCell")
        tableView.dataSource = raceDataSource
    }

    /// Reload the table view's data on the main thread.
    private func reloadDataOnMainThread() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    // MARK: - UITableViewDelegate
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
