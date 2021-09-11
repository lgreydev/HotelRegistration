//
//  RegistrationTableViewController.swift
//  HotelRegistration
//
//  Created by Sergey Lukaschuk on 11.09.2021.
//

import UIKit

class RegistrationTableViewController: UITableViewController {

    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailAddressTextField: UITextField!
    
    @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem) {

        var registration = Registration()

        registration.firstName = firstNameTextField.text!
        registration.lastName = lastNameTextField.text!
        registration.emailAddress = emailAddressTextField.text!
        
        print(registration)
    }
    
}
