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
    var shortName: String
    var price: Int
}

extension RoomType: Equatable {
    static func == (lhs: RoomType, rhs: RoomType) -> Bool {
        return lhs.id == rhs.id
    }
}
