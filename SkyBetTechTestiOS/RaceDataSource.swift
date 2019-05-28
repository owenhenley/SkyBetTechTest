//
//  RaceDataSource+Delegate.swift
//  SkyBetTechTestiOS
//

import UIKit

/// UITableViewDataSource for the RacesViewController.
class RaceDataSource: NSObject, UITableViewDataSource {

    var races = [Race]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return races.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "raceCell", for: indexPath) as? RaceTableViewCell else {
            fatalError("Can't use custom cell")
        }

        cell.race = races[indexPath.row]

        return cell
    }
}
