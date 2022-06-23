//
//  RegisterModel.swift
//  SingularityBooking
//
//  Created by Aigerim Abdurakhmanova on 23.06.2022.
//

import Foundation

struct RegisterModel: Encodable {
    let email: String
    let firstName: String
    let lastName: String
    let password: String
}
