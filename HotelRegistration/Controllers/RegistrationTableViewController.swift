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
    
    // MARK: Private Properties
    private var isCheckInDatePickerShown = false {
        didSet { checkInDatePicker.isHidden = !isCheckInDatePickerShown }
    }
    private var isCheckOutDatePickerShown = false {
        didSet { checkOutDatePicker.isHidden = !isCheckOutDatePickerShown }
    }
    private var checkInDateLabelIndexPath = IndexPath(row: 0, section:1)
    private let checkInDatePickerIndexPath = IndexPath(row: 1, section: 1)
    private var checkOutDateLabelIndexPath = IndexPath(row: 2, section: 1)
    private let checkOutDatePickerIndexPath = IndexPath(row: 3, section: 1)
    
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
        print(#line)
    }
}

// MARK: - UITableViewDataSource
extension RegistrationTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerIndexPath:
            return isCheckInDatePickerShown ? UITableView.automaticDimension : 0
        case checkOutDatePickerIndexPath:
            return isCheckOutDatePickerShown ? UITableView.automaticDimension : 0
        default:
            return UITableView.automaticDimension
        }
    }
}

// MARK: - UITableViewDelegate
extension RegistrationTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case checkInDateLabelIndexPath:
            isCheckInDatePickerShown.toggle()
            isCheckOutDatePickerShown = false
        case checkOutDateLabelIndexPath:
            isCheckOutDatePickerShown.toggle()
            isCheckInDatePickerShown = false
        default:
            break
        }
        tableView.reloadData()
    }
}
