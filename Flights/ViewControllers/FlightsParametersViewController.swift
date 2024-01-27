//
//  FlightsParametersViewController.swift
//  Flights
//
//  Created by Daniil Rassadin on 26/12/23.
//

import UIKit

protocol FlightsParametersViewControllerDelegate: AnyObject {
    func updateFlights()
}

final class FlightsParametersViewController: UIViewController {
    
    // MARK: - Properties
    private weak var delegate: FlightsParametersViewControllerDelegate?
    private var modelData: ModelData
    
    enum Segment: Int, CaseIterable, CustomStringConvertible {
        case date
        case airport
        
        var description: String {
            switch self {
            case .date: return String(localized: "Date", comment: "Segment name")
            case .airport: return String(localized: "Airport", comment: "Segment name")
            }
        }
    }
    
    // MARK: - UI components
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: Segment.allCases.map({ $0.description }))
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    private let airportPicker = UIPickerView()
    
    private let updateButton: UIButton = {
        let button = UIButton()
        button.setTitle(String(localized: "Update Flights"), for: .normal)
        button.configuration = .borderedProminent()
        return button
    }()
    
    // MARK: - Lifecycle
    init(modelData: ModelData, delegate: FlightsParametersViewControllerDelegate? = nil) {
        self.modelData = modelData
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        airportPicker.dataSource = self
        airportPicker.delegate = self
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .systemBackground
        datePicker.date = modelData.currentDate
        addSubviews()
        setupConstraints()
        updateButton.addTarget(
            self,
            action: #selector(updateFlights),
            for: .touchUpInside
        )
        segmentedControl.addTarget(
            self,
            action: #selector(changeParameter(sender:)),
            for: .valueChanged
        )
        airportPicker.isHidden = true
        airportPicker.selectRow(
            modelData.airports.firstIndex(where: { $0.iataCode == modelData.currentAirport.iataCode }) ?? 0,
            inComponent: 0,
            animated: false
        )
    }
    
    private func addSubviews() {
        view.addSubview(segmentedControl)
        view.addSubview(datePicker)
        view.addSubview(airportPicker)
        view.addSubview(updateButton)
    }
    
    private func setupConstraints() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        airportPicker.translatesAutoresizingMaskIntoConstraints = false
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            datePicker.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 5),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            datePicker.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            
            airportPicker.topAnchor.constraint(equalTo: datePicker.topAnchor),
            airportPicker.leadingAnchor.constraint(equalTo: datePicker.leadingAnchor),
            airportPicker.trailingAnchor.constraint(equalTo: datePicker.trailingAnchor),
            airportPicker.heightAnchor.constraint(equalTo: datePicker.heightAnchor),
            
            updateButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 5),
            updateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            updateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            updateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    // MARK: - Navigation
    @objc private func updateFlights() {
        modelData.currentDate = datePicker.date
        modelData.currentAirport = modelData.airports[airportPicker.selectedRow(inComponent: 0)]
        delegate?.updateFlights()
        dismiss(animated: true)
    }
    
    @objc private func changeParameter(sender: UISegmentedControl) {
        guard sender == segmentedControl,
              let segment = Segment(rawValue: sender.selectedSegmentIndex)
        else { return }
        
        let animationDuration: TimeInterval = 0.2
        switch segment {
        case .date:
            airportPicker.fadeOut(withDuration: animationDuration) {
                self.datePicker.fadeIn(withDuration: animationDuration)
            }
        case .airport:
            datePicker.fadeOut(withDuration: animationDuration) {
                self.airportPicker.fadeIn(withDuration: animationDuration)
            }
        }
    }
}

// MARK: - PickerView data source and delegate
extension FlightsParametersViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        modelData.airports.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let airport = modelData.airports[row]
        return airport.city == airport.name ? airport.city : airport.city + " — " + airport.name
    }
}
