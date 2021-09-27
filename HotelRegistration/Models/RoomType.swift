//
//  RoomType.swift
//  HotelRegistration
//
//  Created by Sergey Lukaschuk on 08.09.2021.
//

import Foundation

struct RoomType {
    var id: Int
    var name: String
    var price: Int
    
    init() {
        id = Int()
        name = String()
        price = Int()
    }
    
    init(id: Int, name: String, price: Int) {
        self.id = id
        self.name = name
        self.price = price
    }
}

extension RoomType: Equatable {
    static func == (lhs: RoomType, rhs: RoomType) -> Bool {
        return lhs.id == rhs.id
    }
}

extension RoomType {
    static var all: [RoomType] {
        return [
            RoomType(id: 0, name: "Twin Guest Room", price: 300),
            RoomType(id: 1, name: "King Guest Room", price: 350),
            RoomType(id: 2, name: "King Deluxe Room", price: 400)
        ]
    }
}
