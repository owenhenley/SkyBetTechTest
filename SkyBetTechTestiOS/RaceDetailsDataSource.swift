//
//  RaceDataSource+Delegate.swift
//  SkyBetTechTestiOS
//

import UIKit

/// UITableViewDataSource for the RaceDetailsViewController.
class RaceDetailsDataSource: NSObject, UITableViewDataSource {

    var rides = [Ride]()
    var sortedRides = [Ride]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rides.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "raceDetailsCell", for: indexPath) as? RaceDetailsTableViewCell else {
            print("Using a default table view cell")
            return UITableViewCell()
        }

        if !sortedRides.isEmpty {
            cell.ride = sortedRides[indexPath.row]
        } else {
            cell.ride = rides[indexPath.row]
        }

        return cell
    }
}
