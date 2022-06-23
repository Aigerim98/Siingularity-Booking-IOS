//
//  RegistrationModel.swift
//  Booking
//
//  Created by Aigerim Abdurakhmanova on 23.06.2022.
//

import Foundation

struct Registration: Encodable {
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "firstName"
        case lastName = "lastName"
        case email = "email"
        case password = "password"
    }
}
