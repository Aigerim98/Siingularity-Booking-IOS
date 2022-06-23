//
//  APIManager.swift
//  SingularityBooking
//
//  Created by Aigerim Abdurakhmanova on 23.06.2022.
//

import Foundation
import Alamofire


class APIManager {
    
    static let shareInstance = APIManager()
    
    func registerAPI(register: RegisterModel) {
        let headers: HTTPHeaders = [.contentType("application/json")] //change to our content type
        
        AF.request(registerUrl, method: .post, parameters: register, encoder: JSONParameterEncoder.default, headers: headers).response{response in
            debugPrint(response)
        }
        
    }
}
