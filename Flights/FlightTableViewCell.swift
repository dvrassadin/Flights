//
//  FlightTableViewCell.swift
//  Flights
//
//  Created by Daniil Rassadin on 21/12/23.
//

import UIKit

class FlightTableViewCell: UITableViewCell {
    static let identifier = "flightTableViewCell"
    let flightsType: FlightsType
    
    // MARK: - UI components

    // MARK: - Lifecycle
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, flightsType: FlightsType) {
        self.flightsType = flightsType
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
}
