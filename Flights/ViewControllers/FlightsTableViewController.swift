//
//  FlightsTableViewController.swift
//  Flights
//
//  Created by Daniil Rassadin on 20/12/23.
//

import UIKit

final class FlightsTableViewController: UITableViewController {
    
    // MARK: - Properties
    private let modelData: ModelData
    private let flightsType: FlightsType
    var wereParametersChanged = false
    
    // MARK: - UI components
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Lifecycle
    init(flightsType: FlightsType, modelData: ModelData) {
        self.flightsType = flightsType
        self.modelData = modelData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.navigationItem.title = modelData.currentAirport.name
        setupActivityIndicator()
        setupTableView()
        updateFlights()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if wereParametersChanged { updateFlights() }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch flightsType {
        case .departures: return modelData.departures.count
        case .arrivals: return modelData.arrivals.count
        }
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FlightTableViewCell.identifier,
            for: indexPath
        ) as? FlightTableViewCell else { return UITableViewCell() }
        switch flightsType {
        case .departures:
            cell.configure(with: modelData.departures[indexPath.row], type: flightsType)
        case .arrivals:
            cell.configure(with: modelData.arrivals[indexPath.row], type: flightsType)
        }
        return cell
    }
    
    // MARK: - Data updating
    func updateFlights() {
        if wereParametersChanged { activityIndicator.startAnimating() }
        Task {
            defer {
                self.activityIndicator.stopAnimating()
                self.refreshControl?.endRefreshing()
                self.tabBarController?.navigationItem.title = modelData.currentAirport.name
                UIView.transition(
                    with: self.tableView,
                    duration: 0.4,
                    options: .transitionCrossDissolve
                ) { self.tableView.reloadData() }
            }
            do {
                switch flightsType {
                case .arrivals: try await modelData.updateFlights(.arrivals)
                case .departures: try await modelData.updateFlights(.departures)
                }
                wereParametersChanged = false
            } catch NetworkError.emptyData {
                self.showAlert(
                    title: String(localized: "No Flights"),
                    message: String(localized: "No flights were found. Try to change the date or airport.")
                )
            } catch {
                self.showAlert(
                    title: String(localized: "Loading Error"),
                    message: String(localized: "Failed to load flights. Please try again or check your internet connection.")
                )
            }
        }
    }
    
    // MARK: - Setup UI
    private func setupTableView() {
        tableView.register(
            FlightTableViewCell.self,
            forCellReuseIdentifier: FlightTableViewCell.identifier
        )
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(
            self,
            action: #selector(swipeToRefresh),
            for: .valueChanged
        )
    }
    
    @objc private func swipeToRefresh() {
        updateFlights()
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    // MARK: - Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch flightsType {
        case .departures:
            navigationController?.pushViewController(
                FlightDetailsViewController(
                    flight: modelData.departures[indexPath.row],
                    flightType: flightsType
                ),
                animated: true
            )
        case .arrivals:
            navigationController?.pushViewController(
                FlightDetailsViewController(
                    flight: modelData.arrivals[indexPath.row],
                    flightType: flightsType
                ),
                animated: true
            )
        }
    }
}
