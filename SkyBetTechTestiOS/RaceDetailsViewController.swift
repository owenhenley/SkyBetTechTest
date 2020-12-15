//
//  RaceDetailsViewController.swift
//  SkyBetTechTestiOS
//

import UIKit
import SafariServices

class RaceDetailsViewController: UITableViewController {

    var rideDataSource = RaceDetailsDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setToolbarHidden(true, animated: false)
    }

    // MARK: - Methods

    /// Setup the navigation options.
    private func setupNavigation() {
        title = "Race Details"
        navigationItem.largeTitleDisplayMode = .never
        let number = UIBarButtonItem(title: "⇣ Cloth #", style: .done, target: self, action: #selector(sortClothNumber))
        let form = UIBarButtonItem(title: "⇣ Form", style: .done, target: self, action: #selector(sortFormSummary))
        let odds = UIBarButtonItem(title: "⇣ Odds", style: .done, target: self, action: #selector(sortOdds))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let reset = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetData))
        toolbarItems = [number, spacer, form, spacer, odds, spacer, reset]
    }

    /// Setup the table view.
    private func setupTableView() {
        let nib = UINib(nibName: "RaceDetailsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "raceDetailsCell")
        tableView.dataSource = rideDataSource
    }


// MARK: - UITableViewDelegate

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


// MARK: - Sorting Methods

    /// Sort the tableview by cloth number.
    @objc private func sortClothNumber() {
        let sortedRides = rideDataSource.rides.sorted(by: {  $0.clothNumber < $1.clothNumber })
        replaceRides(with: sortedRides)
    }

    /// Sort the tableview by form.
    @objc private func sortFormSummary() {
        // I honestly have no idea what a form summary even is, nor can I seem to accurately find out.
        let sortedRides = rideDataSource.rides.sorted(by: {  $0.formSummary < $1.formSummary })
        replaceRides(with: sortedRides)
    }

    /// Sort the tableview by odds.
    @objc private func sortOdds() {
        // This could possibly be more accurately sorted by sperating the components based on the "/", and then
        // convert the elements into Int's, and then divide them to get an accurate current odds result to sort from.
        // Again, a little unsure on how betting works, but im absolutly open to learning!
        let sortedRides = rideDataSource.rides.sorted(by: {  $0.currentOdds < $1.currentOdds })
        replaceRides(with: sortedRides)
    }

    /// Reset the tableview to the original order.
    @objc private func resetData() {
        rideDataSource.sortedRides.removeAll()
        tableView.reloadData()
    }

    /// Helper method to set the dataSource's sorted rides.
    private func replaceRides(with rides: [Ride]) {
        rideDataSource.sortedRides = rides
        tableView.reloadData()
    }
}
