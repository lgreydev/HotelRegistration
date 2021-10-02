//
//  RegistrationListTableViewController.swift
//  HotelRegistration
//
//  Created by Sergey Lukaschuk on 02.10.2021.
//

import UIKit

class RegistrationListTableViewController: UITableViewController {
    
   
    // private var registrationList: [Registration?]

    override func viewDidLoad() {
        super.viewDidLoad()

//        guestName.text = "Guest Name"
//       guestRoom.text = "Guest Room"
//
//        datesOfStay.text = "date - date"
//
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 1 // registrationList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListRooms", for: indexPath)
        
        //let guest = registrationList[indexPath]
        
        cell.textLabel?.text = "Name"
        cell.detailTextLabel?.text = "detail"
        return  cell
    }

    
}
