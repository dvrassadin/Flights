//
//  FlightsTableViewController.swift
//  Flights
//
//  Created by Daniil Rassadin on 20/12/23.
//

import UIKit

final class FlightsTableViewController: UITableViewController {
    
    // MARK: - Properties
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var flights = [Flight]()
    private let flightsType: FlightsType
    private let networkService: NetworkService
    private(set) var date = Date()
    
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
        updateFlights(date: date)
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
    
    func updateFlights(date: Date) {
        if !Calendar.current.isDate(date, inSameDayAs: self.date) {
            self.date = date
            activityIndicator.startAnimating()
        }
        Task {
            do {
                switch flightsType {
                case .arrivals:
                    flights = try await networkService.getFlight(.arrivals, date: date)
                case .departures:
                    flights = try await networkService.getFlight(.departures, date: date)
                }
                DispatchQueue.main.async {
                    UIView.transition(
                        with: self.tableView,
                        duration: 0.5,
                        options: .transitionCrossDissolve
                    ) {
                        self.tableView.reloadData()
                    }
                    if self.activityIndicator.isAnimating {
                        self.activityIndicator.stopAnimating()
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
        updateFlights(date: date)
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
    
    // MARK: - Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(
            FlightDetailsViewController(flight: flights[indexPath.row], flightType: flightsType),
            animated: true
        )
    }
}
