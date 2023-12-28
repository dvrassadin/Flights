//
//  FlightsParametersViewController.swift
//  Flights
//
//  Created by Daniil Rassadin on 26/12/23.
//

import UIKit

protocol FlightsParametersViewControllerDelegate: AnyObject {
    func updateFlightsParameters(date: Date)
}

final class FlightsParametersViewController: UIViewController {
    
    // MARK: - Properties
    private weak var delegate: FlightsParametersViewControllerDelegate?
    private var date: Date
    
    // MARK: - UI components
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Update Flights", for: .normal)
        button.configuration = .borderedProminent()
        return button
    }()
    
    // MARK: - Lifecycle
    init(date: Date, delegate: FlightsParametersViewControllerDelegate? = nil) {
        self.date = date
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        doneButton.addTarget(self, action: #selector(updateFlightsParameters), for: .touchUpInside)
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .systemBackground
        datePicker.date = date
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(datePicker)
        view.addSubview(doneButton)
    }
    
    private func setupConstraints() {
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            doneButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 10),
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    // MARK: - Navigation
    @objc private func updateFlightsParameters() {
        delegate?.updateFlightsParameters(date: datePicker.date)
        dismiss(animated: true)
    }
}
