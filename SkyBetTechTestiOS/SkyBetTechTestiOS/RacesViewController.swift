//
//  RacesViewController.swift
//  SkyBetTechTestiOS
//

import UIKit

class RacesViewController: UITableViewController {
    // MARK: - Properties
    var races = [Race]()

    // MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigation()
        fetchRaces()
    }

    /// Fetch all race data.
    private func fetchRaces() {
        NetworkController.shared.fetchRaces { races, error in
            if error != nil {
                let ac = UIAlertController(title: "Error", message: "\(String(describing: error))", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(ac, animated: true)
                return
            }

            guard let races = races else { return }
            self.races = races

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    /// Setup the navigations options.
    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - UITableView
    /// Setup the table view
    private func setupTableView() {
        let nib = UINib(nibName: "RaceTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "raceCell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return races.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "raceCell", for: indexPath) as? RaceTableViewCell else {
            print("Using a default table view cell")
            return RaceTableViewCell()
        }

        cell.race = races[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = RaceDetailsViewController()
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
