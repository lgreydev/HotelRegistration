//
//  RegistrationTableViewController.swift
//  HotelRegistration
//
//  Created by Sergey Lukaschuk on 11.09.2021.
//

import UIKit

class RegistrationTableViewController: UITableViewController {
    
    // MARK: - IBOutlet
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailAddressTextField: UITextField!
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        configureDatePicker()
        updateDateView()
    }
    
    // MARK: - Private Methods
    private func updateDateView() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale.current
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
    }
    
    private func configureDatePicker() {
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(60 * 60 * 24)
    }
        
    // MARK: - IBAction
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        configureDatePicker()
        updateDateView()
    }
    
    @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem) {
        var registration = Registration()
        registration.firstName = firstNameTextField.text!
        registration.lastName = lastNameTextField.text!
        registration.emailAddress = emailAddressTextField.text!
        registration.checkInDate = checkInDatePicker.date
        registration.checkOutDate = checkOutDatePicker.date
        
        print(registration)
    }
    
}
