//
//  RegistrationListTableViewController.swift
//  HotelRegistration
//
//  Created by Sergey Lukaschuk on 02.10.2021.
//

import UIKit

class RegistrationListTableViewController: UITableViewController {
    
   
    var registrationList: [Guest?] = []
    var closure: (([Guest?]) -> ())?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        closure?(registrationList)
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! RegistrationTableViewController
        destination.registrationList = registrationList
    }
 */
}


// MARK: - Table view data source
extension RegistrationListTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registrationList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListRooms", for: indexPath)
        
        //let guest = registrationList[indexPath]
        
        cell.textLabel?.text = registrationList[indexPath.row]?.name
        cell.detailTextLabel?.text = registrationList[indexPath.row]?.detail
        return  cell
    }
}


struct Guest {
    let name: String
    let detail: String
}
