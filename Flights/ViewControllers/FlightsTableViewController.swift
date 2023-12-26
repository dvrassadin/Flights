//
//  FlightsTableViewController.swift
//  Flights
//
//  Created by Daniil Rassadin on 20/12/23.
//

import UIKit

final class FlightsTableViewController: UITableViewController {
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Properties
    
    let flightsType: FlightsType
    private let networkService: NetworkService
    private var flights = [Flight]()
    
    // MARK: - Lifecycle
    
    init(flightsType: FlightsType, networkService: NetworkService) {
        self.flightsType = flightsType
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        setupTableView()
        updateFlights()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FlightTableViewCell.identifier,
            for: indexPath
        ) as? FlightTableViewCell else { return UITableViewCell() }
        cell.configure(with: flights[indexPath.row], type: flightsType)
        return cell
    }
    
    private func updateFlights() {
        Task {
            do {
                switch flightsType {
                case .arrivals:
                    flights = try await networkService.getFlight(.arrivals)
                case .departures:
                    flights = try await networkService.getFlight(.departures)
                }
                DispatchQueue.main.async {
                    if self.activityIndicator.isAnimating {
                        self.activityIndicator.stopAnimating()
                    }
                    UIView.transition(
                        with: self.tableView,
                        duration: 0.5,
                        options: .transitionCrossDissolve
                    ) {
                        self.tableView.reloadData()
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: - SetupUI
    
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
        refreshControl?.endRefreshing()
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
}
