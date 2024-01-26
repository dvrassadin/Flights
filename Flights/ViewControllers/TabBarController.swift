//
//  TabBarController.swift
//  Flights
//
//  Created by Daniil Rassadin on 20/12/23.
//

import UIKit

final class TabBarController: UITabBarController {
    let networkService: NetworkService = YandexNetworkService()
    
    // MARK: - UI components
    private let copyrightTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemYellow
        textView.textAlignment = .center
        textView.dataDetectorTypes = .link
        textView.isEditable = false
        textView.isSelectable = true
        textView.isScrollEnabled = false
        textView.isHidden = true
        return textView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        setupTabs()
        setupCopyrightTextView()
        Task { await showCopyrightTextView() }
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: .plain,
            target: self,
            action: #selector(showFlightsParameters)
        )
    }
    
    private func setupTabs() {
        let departuresViewController = FlightsTableViewController(
            flightsType: .departures,
            networkService: networkService
        )
        let departureImage = UIImage(systemName: "airplane.departure")
        let departuresTabBarItem = UITabBarItem(
            title: String(localized: FlightsType.departures.rawValue),
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
            title: String(localized: FlightsType.arrivals.rawValue),
            image: arrivalImage,
            selectedImage: arrivalImage
        )
        arrivalsViewController.tabBarItem = arrivalsTabBarItem
        
        viewControllers = [departuresViewController, arrivalsViewController]
    }
    
    private func setupCopyrightTextView() {
        view.addSubview(copyrightTextView)
        copyrightTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            copyrightTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            copyrightTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            copyrightTextView.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: -10)
        ])
    }
    
    private func showCopyrightTextView() async {
        guard let copyright = try? await networkService.getCopyright() else { return }
        copyrightTextView.text = copyright.text + "\n\n" + copyright.url
        copyrightTextView.fadeIn(withDuration: 1)
    }
    
    // MARK: - Navigation
    @objc private func showFlightsParameters() {
        guard let flightsVC = selectedViewController as? FlightsTableViewController else { return }
        let settingsVC = FlightsParametersViewController(date: flightsVC.date, airport: flightsVC.airport, delegate: self)
        guard let sheet = settingsVC.sheetPresentationController else { return }
        sheet.prefersGrabberVisible = true
        sheet.detents = [.medium()]
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
