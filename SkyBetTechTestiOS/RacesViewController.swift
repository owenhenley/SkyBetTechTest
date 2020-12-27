//
//  RacesViewController.swift
//  SkyBetTechTestiOS
//

import UIKit

class RacesViewController: UITableViewController {

    private var viewModels = [RaceViewModel]()
//    private let dataSource = RacesViewControllerDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRaces()
    }

    /// Fetch all race data.
    @objc private func fetchRaces() {
        ActivityIndicator.start(for: view)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            defer { ActivityIndicator.stop() }
            
            HorseRacesService().fetchRaces { races, error in
                let alert = Alert()
                if let error = error {
                    alert.show(error: error,
                               on: self,
                               title: "Oops",
                               message: "There was an problem fetching the races, please check your internet connection")
                    return
                }

                guard let races = races else {
                    alert.show(error: error,
                               on: self,
                               title: "Oops",
                               message: "There was an problem fetching the races, please check your internet connection")
                    return
                }
                
                
                self.viewModels = races.map({ return RaceViewModel(race: $0) })
                self.reloadDataOnMainThread()
            }

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.tableView.refreshControl?.endRefreshing()
            }
        }
    }

    // MARK: - UITableView
    
    /// Setup the table view
    private func setupTableView() {
        let nib = UINib(nibName: "RaceTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "raceCell")
        self.enablePullToRefresh { control in
            control.addTarget(self, action: #selector(fetchRaces), for: .valueChanged)
        }
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        navigationController?.toolbar.tintColor = .black
    }

// MARK: - UITableViewDelegate & DataSource

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = indexPath.row
        let detailsVC = RaceDetailsViewController()
        if let rides = viewModels[selectedRow].rides() {
            detailsVC.viewModels = rides

            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "raceCell", for: indexPath) as? RaceTableViewCell else {
            fatalError("Can't use custom cell")
        }

        cell.raceViewModel = viewModels[indexPath.row]

        return cell
    }
}
