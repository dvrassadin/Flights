//
//  TabBarController.swift
//  Flights
//
//  Created by Daniil Rassadin on 20/12/23.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: .plain,
            target: self,
            action: #selector(showFlightsParameters)
        )
    }
    
    // MARK: - Setup UI
    private func setupTabs() {
        let networkService: NetworkService = YandexNetworkService()
        
        let departuresViewController = FlightsTableViewController(
            flightsType: .departures,
            networkService: networkService
        )
        let departureImage = UIImage(systemName: "airplane.departure")
        let departuresTabBarItem = UITabBarItem(
            title: FlightsType.departures.rawValue,
            image: departureImage,
            selectedImage: departureImage
        )
        departuresViewController.tabBarItem = departuresTabBarItem
        
        let arrivalsViewController = FlightsTableViewController(
            flightsType: .arrivals,
            networkService: networkService
        )
        let arrivalImage = UIImage(systemName: "airplane.arrival")
        let arrivalsTabBarItem = UITabBarItem(
            title: FlightsType.arrivals.rawValue,
            image: arrivalImage,
            selectedImage: arrivalImage
        )
        arrivalsViewController.tabBarItem = arrivalsTabBarItem
        
        viewControllers = [departuresViewController, arrivalsViewController]
    }
    
    @objc private func showFlightsParameters() {
        guard let flightsVC = selectedViewController as? FlightsTableViewController else { return }
        let settingsVC = FlightsParametersViewController(date: flightsVC.date, airport: flightsVC.airport, delegate: self)
        guard let sheet = settingsVC.sheetPresentationController else { return }
        sheet.prefersGrabberVisible = true
        sheet.detents = [.medium(), .large()]
        present(settingsVC, animated: true)
    }
}

// MARK: - FlightsParametersViewControllerDelegate

extension TabBarController: FlightsParametersViewControllerDelegate {
    func updateFlightsParameters(date: Date, airport: Airport) {
        guard let flightsVC = selectedViewController as? FlightsTableViewController else { return }
        flightsVC.updateFlights(date: date, airport: airport)
    }
}
