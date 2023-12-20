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
    }
    
    // MARK: - Setup UI
    
    private func addTabBarItems() {
        let networkService: NetworkService = YandexNetworkService()
        
        let arrivalsViewController = FlightsTableViewController(
            flightsType: .arrivals,
            networkService: networkService
        )
        let arrivalsTabBarItem = UITabBarItem(
            title: FlightsType.arrivals.rawValue,
            image: UIImage(systemName: "airplane.arrival"),
            selectedImage: UIImage(systemName: "airplane.arrival")
        )
        arrivalsViewController.tabBarItem = arrivalsTabBarItem
        
        let departuresViewController = FlightsTableViewController(
            flightsType: .arrivals,
            networkService: networkService
        )
        let departuresTabBarItem = UITabBarItem(
            title: FlightsType.departures.rawValue,
            image: UIImage(systemName: "airplane.departure"),
            selectedImage: UIImage(systemName: "airplane.departure")
        )
        departuresViewController.tabBarItem = departuresTabBarItem
        
        viewControllers = [arrivalsViewController, departuresViewController]
    }
}
