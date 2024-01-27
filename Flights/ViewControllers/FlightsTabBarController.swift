//
//  FlightsTabBarController.swift
//  Flights
//
//  Created by Daniil Rassadin on 20/12/23.
//

import UIKit

final class FlightsTabBarController: UITabBarController {
    let modelData: ModelData
    
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
    init(modelData: ModelData) {
        self.modelData = modelData
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
        setupTabs()
        setupCopyrightTextView()
        Task { await showCopyrightTextView() }
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(showFlightsParameters)
        )
    }
    
    private func setupTabs() {
        let departuresViewController = FlightsTableViewController(
            flightsType: .departures,
            modelData: modelData
        )
        let departureImage = UIImage(systemName: "airplane.departure")
        let departuresTabBarItem = UITabBarItem(
            title: String(localized: FlightsType.departures.rawValue),
            image: departureImage,
            selectedImage: departureImage
        )
        departuresViewController.tabBarItem = departuresTabBarItem
        
        let arrivalsViewController = FlightsTableViewController(
            flightsType: .arrivals, modelData: modelData)
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
        guard let copyright = try? await modelData.copyright else { return }
        copyrightTextView.text = copyright.text + "\n\n" + copyright.url
        copyrightTextView.fadeIn(withDuration: 1)
    }
    
    // MARK: - Navigation
    @objc private func showFlightsParameters() {
        let settingsVC = FlightsParametersViewController(
            modelData: modelData,
            delegate: self
        )
        guard let sheet = settingsVC.sheetPresentationController else { return }
        sheet.prefersGrabberVisible = true
        sheet.detents = [.medium()]
        present(settingsVC, animated: true)
    }
}

// MARK: - FlightsParametersViewControllerDelegate
extension FlightsTabBarController: FlightsParametersViewControllerDelegate {
    func updateFlights() {
        viewControllers?.forEach {
            if let flightsVC = $0 as? FlightsTableViewController {
                flightsVC.wereParametersChanged = true
            }
        }
        guard let flightsVC = selectedViewController as? FlightsTableViewController else { return }
        flightsVC.updateFlights()
    }
}
