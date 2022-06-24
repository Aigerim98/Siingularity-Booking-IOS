//
//  File.swift
//  Booking
//
//  Created by Aigerim Abdurakhmanova on 24.06.2022.
//

import Foundation

struct Booking: Decodable {
    
//    enum CodingKeys: String, CodingKey {
//        case timeSlot = "timeSlot"
//        case data = "data"
//        case room = "room"
//    }
    //let id: Int
    let timeSlot: String?
    let date: String?
    let room: Int
}

struct BookingsEntity: Decodable {
    let booking: [Booking]
}

struct TimeSlots: Decodable {
    let availableTimeSlots: [String]
}
