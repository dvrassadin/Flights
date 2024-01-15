//
//  FlightDetailsViewController.swift
//  Flights
//
//  Created by Daniil Rassadin on 26/12/23.
//

import UIKit

final class FlightDetailsViewController: UIViewController {
    // MARK: - Properties
    private let flight: Flight
    private let flightType: FlightsType
    
    // MARK: UI components
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        return label
    }()
    
    private let carrierLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        return label
    }()
    
    private let routeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        return label
    }()
    
    private let vehicleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textAlignment = .center
        return label
    }()
    
    private let terminalTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption2)
        label.textAlignment = .center
        label.text = "Terminal"
        return label
    }()
    
    private let terminalNameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        return label
    }()
    
    private let directionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption2)
        label.textAlignment = .center
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textAlignment = .center
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecycle
    init(flight: Flight, flightType: FlightsType) {
        self.flight = flight
        self.flightType = flightType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = flight.number
        addSubviews()
        setupConstraints()
        addData()
    }
    
    private func addSubviews() {
        view.addSubview(numberLabel)
        view.addSubview(carrierLabel)
        view.addSubview(routeLabel)
        view.addSubview(vehicleLabel)
        view.addSubview(terminalTitleLabel)
        view.addSubview(terminalNameLabel)
        view.addSubview(directionTitleLabel)
        view.addSubview(dateLabel)
        view.addSubview(timeLabel)
    }
    
    private func setupConstraints() {
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        carrierLabel.translatesAutoresizingMaskIntoConstraints = false
        routeLabel.translatesAutoresizingMaskIntoConstraints = false
        vehicleLabel.translatesAutoresizingMaskIntoConstraints = false
        terminalTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        terminalNameLabel.translatesAutoresizingMaskIntoConstraints = false
        directionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            numberLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            numberLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            carrierLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 10),
            carrierLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            carrierLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            carrierLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            routeLabel.topAnchor.constraint(equalTo: carrierLabel.bottomAnchor, constant: 25),
            routeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            routeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            routeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            vehicleLabel.topAnchor.constraint(equalTo: routeLabel.bottomAnchor, constant: 5),
            vehicleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            vehicleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            vehicleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            terminalTitleLabel.topAnchor.constraint(equalTo: vehicleLabel.bottomAnchor, constant: 25),
            terminalTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            terminalTitleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            terminalTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            terminalNameLabel.topAnchor.constraint(equalTo: terminalTitleLabel.bottomAnchor, constant: 5),
            terminalNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            terminalNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            terminalNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            directionTitleLabel.topAnchor.constraint(equalTo: terminalNameLabel.bottomAnchor, constant: 25),
            directionTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            directionTitleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            directionTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: directionTitleLabel.bottomAnchor, constant: 5),
            dateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            dateLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            timeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            timeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func addData() {
        numberLabel.text = flight.number
        if let carrierIATA = flight.carrierIATA {
            carrierLabel.text = carrierIATA + " " + flight.carrierTitle
        } else {
            carrierLabel.text = flight.carrierTitle
        }
        routeLabel.text = flight.title
        vehicleLabel.text = flight.vehicle
        terminalNameLabel.text = flight.terminal == nil ? "unknown" : flight.terminal
        switch flightType {
        case .departures:
            directionTitleLabel.text = "Departure"
            dateLabel.text = flight.departure?.formatted(date: .long, time: .omitted)
            timeLabel.text = flight.departure?.formatted(date: .omitted, time: .shortened)
        case .arrivals:
            directionTitleLabel.text = "Arrival"
            dateLabel.text = flight.arrival?.formatted(date: .long, time: .omitted)
            timeLabel.text = flight.arrival?.formatted(date: .omitted, time: .shortened)
        }
    }
}
