//
//  RacesViewController.swift
//  SkyBetTechTestiOS
//

import UIKit

class RacesViewController: UITableViewController {

    var races: [Race] = []
    private var viewModel: RaceViewModel = RaceViewModel()
    
    init(viewModel: RaceViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ActivityIndicator.start(for: view)
        fetchRaces()
    }
    
    @objc func fetchRaces() {
        viewModel.fetchRaces() { [weak self] result in
            switch result {
            case .success(let races):
                self?.races = races
            case .failure(let error):
                guard let self = self else { return }
                let alert = Alert()
                alert.show(error: error,
                           on: self,
                           title: "Oops",
                           message: "There was an problem fetching the races, please check your internet connection")
            }
            DispatchQueue.main.async {
                ActivityIndicator.stop()
                self?.tableView.refreshControl?.endRefreshing()
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: - UITableView
    
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
        if let indexPath = tableView.indexPathForSelectedRow {
            let selectedRow = indexPath.row
            let race = races[selectedRow]
            let rideViewModel = RideViewModel(rides: race.rides)
            let detailsVC = RaceDetailsViewController(viewModel: rideViewModel)
            detailsVC.viewModel = rideViewModel
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        races.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "raceCell", for: indexPath) as? RaceTableViewCell else {
            fatalError("Can't use custom cell")
        }

        cell.race = races[indexPath.row]

        return cell
    }
}
