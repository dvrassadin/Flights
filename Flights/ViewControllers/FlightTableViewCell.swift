//
//  FlightTableViewCell.swift
//  Flights
//
//  Created by Daniil Rassadin on 21/12/23.
//

import UIKit

final class FlightTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "FlightTableViewCell"
    private let dateFormat = Date.FormatStyle().day(.twoDigits).month(.abbreviated)
    
    // MARK: - UI components
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    private let dateStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .systemRed
        return label
    }()
    
    private let flightStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 5
        return stack
    }()
    
    private let vehicleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .systemGray
        return label
    }()

    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func addSubviews() {
        dateStack.addArrangedSubview(timeLabel)
        dateStack.addArrangedSubview(dateLabel)
        contentView.addSubview(dateStack)
        flightStack.addArrangedSubview(titleLabel)
        flightStack.addArrangedSubview(numberLabel)
        contentView.addSubview(flightStack)
        contentView.addSubview(vehicleLabel)
    }
    
    private func setupConstraints() {
        dateStack.translatesAutoresizingMaskIntoConstraints = false
        flightStack.translatesAutoresizingMaskIntoConstraints = false
        vehicleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            dateStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            flightStack.leadingAnchor.constraint(equalTo: dateStack.trailingAnchor, constant: 20),
            flightStack.topAnchor.constraint(equalTo: dateStack.topAnchor),
            flightStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            flightStack.bottomAnchor.constraint(equalTo: dateStack.bottomAnchor),
            vehicleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 3),
            vehicleLabel.leadingAnchor.constraint(equalTo: dateStack.leadingAnchor),
            vehicleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            vehicleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    func configure(with flight: Flight, type: FlightsType) {
        switch type {
        case .departures:
            timeLabel.text = flight.departure?.formatted(date: .omitted, time: .shortened)
            dateLabel.text = flight.departure?.formatted(dateFormat)
        case .arrivals:
            timeLabel.text = flight.arrival?.formatted(date: .omitted, time: .shortened)
            dateLabel.text = flight.arrival?.formatted(dateFormat)
        }
        titleLabel.text = flight.title
        numberLabel.text = flight.number
        vehicleLabel.text = flight.vehicle
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        timeLabel.text = nil
        dateLabel.text = nil
        titleLabel.text = nil
        numberLabel.text = nil
        vehicleLabel.text = nil
    }
    
}
