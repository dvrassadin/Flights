//
//  FlightsTableViewController.swift
//  Flights
//
//  Created by Daniil Rassadin on 20/12/23.
//

import UIKit

final class FlightsTableViewController: UITableViewController {
    let flightsType: FlightsType
    let networkService: NetworkService
    var flights = [Flight]()
    
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        updateFlights()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return flights.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let flight = flights[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = flight.title
        content.secondaryText = flight.number
        cell.contentConfiguration = content
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
