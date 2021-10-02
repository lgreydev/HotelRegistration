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
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    @IBOutlet weak var numberOfAdultsStepper: UIStepper!
    @IBOutlet weak var numberOfChildrenLabel: UILabel!
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    @IBOutlet weak var wifiSwitch: UISwitch!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var roomControl: UISegmentedControl!
    @IBOutlet weak var priceWifiLabel: UILabel!
    
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
    private let allRoomPrice = RoomType.all
    private let priceWifi = 10
    private var registration = Registration()
    private var registrationList: [Guest?] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        configureDatePicker()
        updateDateView()
        updateNumberOfGuests()
    }
    
    // MARK: - Private Methods
    private func updateNumberOfGuests() {
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        numberOfAdultsLabel.text = String(numberOfAdults)
        numberOfChildrenLabel.text = String(numberOfChildren)
    }
    
    private func updateDateView() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale.current
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
        wifiSwitch.isOn = false
        priceWifiLabel.text = String(priceWifi) + "$"
    }
    
    private func configureDatePicker() {
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(60 * 60 * 24)
    }
    
    private func alertMessage() {
        var textTitle = ""
        var textMessage = ""
        
        if registration.firstName.isEmpty {
            textTitle = "Enter your Name!"
            textMessage = "'Name' field is must be filled!"
        }
        
        let alert = UIAlertController(title: textTitle, message: textMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func addToRegistrationList() {
        //registrationList.append(Registration?)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! RegistrationListTableViewController
        
        saveData()
        destination.registrationList = self.registrationList
        
        let source = segue.source as! RegistrationTableViewController
        updateData(date: source)
        
    }
    
    private func saveData() {
        guard let firstName = firstNameTextField.text else { fatalError() }
        guard let lastName = lastNameTextField.text else { return }
        guard let checkIn = checkInDateLabel.text else { return }
        guard let checkOut = checkOutDateLabel.text else { return }
        guard let price = priceLabel.text else { return }
        let room = registration.roomType.name
        let newGuest = Guest(
            name: firstName + " " + lastName,
            detail: checkIn + " – " + checkOut + "\n" + room + "\n" + price
        )
        registrationList.append(newGuest)
    }
    
    private func updateData(date: RegistrationTableViewController) {
        date.firstNameTextField.text = ""
        date.lastNameTextField.text = ""
        date.roomControl.selectedSegmentIndex = 0
        date.wifiSwitch.isOn = false
        date.priceLabel.text = String(allRoomPrice[0].price)
    }
    
    
    // MARK: - IBAction
    @IBAction func switchAction(_ sender: UISwitch) {
        let priceWifi = sender.isOn ? priceWifi : 0
        let indexSegment = roomControl.selectedSegmentIndex
        priceLabel.text = String(allRoomPrice[indexSegment].price + priceWifi) + "$"
    }
    
    @IBAction func chooseRooms(_ sender: UISegmentedControl) {
        let indexSegment = sender.selectedSegmentIndex
        if wifiSwitch.isOn {
            priceLabel.text = String(allRoomPrice[indexSegment].price + priceWifi) + "$"
        } else {
            priceLabel.text = String(allRoomPrice[indexSegment].price) + "$"
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuests()
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        configureDatePicker()
        updateDateView()
    }
    
    @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem) {
        registration.firstName = firstNameTextField.text!
        registration.lastName = lastNameTextField.text!
        registration.emailAddress = emailAddressTextField.text!
        registration.checkInDate = checkInDatePicker.date
        registration.checkOutDate = checkOutDatePicker.date
        registration.numberOfAdults = Int(numberOfAdultsStepper.value)
        registration.numberOfChildren = Int(numberOfChildrenStepper.value)
        registration.wifi = wifiSwitch.isOn
        registration.roomType.id = roomControl.selectedSegmentIndex
        registration.roomType.name = allRoomPrice[roomControl.selectedSegmentIndex].name
        registration.roomType.price =
            (allRoomPrice[roomControl.selectedSegmentIndex].price) + (wifiSwitch.isOn ? priceWifi : 0)
        if registration.firstName.isEmpty { alertMessage() }
        
        performSegue(withIdentifier: "RegistrationList", sender: sender)
        print(#line, registration)
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
