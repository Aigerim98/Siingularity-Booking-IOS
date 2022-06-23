//
//  APIManager.swift
//  Booking
//
//  Created by Aigerim Abdurakhmanova on 23.06.2022.
//

import Foundation
import Alamofire

class APIManager {
    
    static var shareInstance = APIManager()
    
    func registerAPI(register: Registration, completionHandler: @escaping (Bool) -> ()) {
        
        let header: HTTPHeaders = [.accept("*/*"), .contentType("application/json")]

        
        AF.request(registerUrl, method: .post, parameters: register, encoder: JSONParameterEncoder.default, headers: header).response { response in
            debugPrint(response.result)
            //print(registerUrl)
            switch response.result {
            case.success(let data):
               // print(data!)
                do{
                    //let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    let json = try JSONSerialization.jsonObject(with: data!)
                    print(json)
                    if response.response?.statusCode == 200 {
                        completionHandler(true)
                    }else {
                        completionHandler(false)
                    }
                }catch{
                    print(error)
                }
            case.failure(let error):
                print(error)
                completionHandler(false)
            }
            
        }
    }
    
    func logInApi(login: LoginModel, completionHandler: @escaping (Bool) -> ()) {
        let header: HTTPHeaders = [.accept("*/*"), .contentType("application/json")]

        AF.request(loginUrl, method: .post, parameters: login, encoder: JSONParameterEncoder.default, headers: header).response { response in
            debugPrint(response.result)
            switch response.result {
            case.success(let data):
               // print(data!)
                do{
                    let json = try JSONSerialization.jsonObject(with: data!)
                    print(json)
                    if response.response?.statusCode == 200 {
                        completionHandler(true)
                    }else {
                        completionHandler(false)
                    }
                }catch{
                    print(error)
                }
            case.failure(let error):
                print(error)
                completionHandler(false)
            }
            
        }
    }
    
}
