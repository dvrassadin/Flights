//
//  TabBarController.swift
//  Flights
//
//  Created by Daniil Rassadin on 20/12/23.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addTabBarItems()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .plain,
            target: self,
            action: #selector(openDatePicker)
        )
    }
    
    // MARK: - Setup UI
    
    private func addTabBarItems() {
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
    
    @objc private func openDatePicker() {
        
    }
}
