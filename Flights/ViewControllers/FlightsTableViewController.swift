//
//  FlightsTableViewController.swift
//  Flights
//
//  Created by Daniil Rassadin on 20/12/23.
//

import UIKit

final class FlightsTableViewController: UITableViewController {
    
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
        tableView.register(
            FlightTableViewCell.self,
            forCellReuseIdentifier: FlightTableViewCell.identifier
        )
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
//        let flight = flights[indexPath.row]
//        var content = cell.defaultContentConfiguration()
//        content.text = flight.title
//        var dateAndTime: Date?
//        if let date = flight.arrival {
//            dateAndTime = date
//        } else if let date = flight.departure {
//            dateAndTime = date
//        }
//        content.secondaryText = dateAndTime?.formatted()
//        cell.contentConfiguration = content
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
                DispatchQueue.main.async { self.tableView.reloadData() }
            } catch {
                print(error)
            }
        }
    }
}
