//
//  Registration.swift
//  HotelRegistration
//
//  Created by Sergey Lukaschuk on 07.09.2021.
//

import Foundation

struct Registration {
    
    var firstName: String
    var lastName: String
    var emailAddress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    
    var numberOfAdults: Int
    var numberOfChildren: Int
    
    var roomType: Bool
    var wifi: Bool
}
