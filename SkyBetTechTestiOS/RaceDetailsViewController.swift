//
//  RaceDetailsViewController.swift
//  SkyBetTechTestiOS
//

import UIKit
import SafariServices
import LocalAuthentication

class RaceDetailsViewController: UITableViewController {
    
    var viewModel: RideViewModel

    private var activeBets = [Int: Bool]()
    
    init(viewModel: RideViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    private func setupNavigation() {
        title = "Race Details"
        navigationItem.largeTitleDisplayMode = .never
        let number = UIBarButtonItem(title: "⇣ Cloth #", style: .done, target: self, action: #selector(sortClothNumber))
        let form = UIBarButtonItem(title: "⇣ Form", style: .done, target: self, action: #selector(sortFormSummary))
        let odds = UIBarButtonItem(title: "⇣ Odds", style: .done, target: self, action: #selector(sortOdds))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let reset = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetData))
        toolbarItems = [number, spacer, form, spacer, odds, spacer, reset]
        if #available(iOS 13.0, *) {
            navigationController?.toolbar.tintColor = UITraitCollection.current.userInterfaceStyle == .dark ? .white : .black
            navigationController?.navigationBar.tintColor = UITraitCollection.current.userInterfaceStyle == .dark ? .white : .black
        }
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "RaceDetailsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "raceDetailsCell")
    }

    // MARK: - UITableViewDelegate & DataSource
    
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sortedRides.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "raceDetailsCell", for: indexPath) as? RaceDetailsTableViewCell else {
            fatalError("Can't use custom cell")
        }
        cell.betDelegate = self
        let ride = viewModel.sortedRides[indexPath.row]
        cell.ride = ride
        cell.betPlaced = activeBets[ride.clothNumber] ?? false
        return cell
    }
    
    // MARK: - Sorting Methods
    
    /// Sort the tableview by cloth number.
    @objc func sortClothNumber() {
        viewModel.sortOrder = .clothNumber
        tableView.reloadData()
    }
    
    /// Sort the tableview by form.
    @objc func sortFormSummary() {
        viewModel.sortOrder = .formSummary
        tableView.reloadData()
    }
    
    /// Sort the tableview by odds.
    @objc func sortOdds() {
        viewModel.sortOrder = .odds
        tableView.reloadData()
    }
    
    /// Reset the tableview to the original order.
    @objc private func resetData() {
        viewModel.sortOrder = .none
        tableView.reloadData()
    }
}

extension RaceDetailsViewController: PlaceBetProtocol {
    
    func placeBet(on ride: Ride) {
        let context = LAContext()
        var error: NSError?
        let alert = Alert()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: "Security check") { [weak self] success, authenticationError in
                
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if success {
                        self.activeBets[ride.clothNumber] = true
                        self.reloadDataOnMainThread()
                        alert.show(error: nil, on: self, title: "Your bet is in!", message: "May the odds be ever in your favour.", actions: nil)
                    } else {
                        alert.show(error: nil, on: self, title: "Stop right there", message: "Authentication failed. Please try again.", actions: nil)
                    }
                }
            }
        } else {
            let goToSettings = UIAlertAction(title: "Settings", style: .default) { _ in
                self.goToDeviceSettings()
            }
            
            alert.show(error: nil, on: self, title: "Permissions missing", message: "You need to allow access to FaceID/TouchID to place a bet.", actions: [goToSettings])
        }
    }
    
    @objc private func goToDeviceSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl)
        }
    }
}
