//
//  APIManager.swift
//  Booking
//
//  Created by Aigerim Abdurakhmanova on 23.06.2022.
//

import Foundation
//import Alamofire

enum APINetworkError: Error {
    case dataNotFound
    case httpRequestFailed
}

extension APINetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .dataNotFound:
            return "Error: Did not receive data"
        case .httpRequestFailed:
            return "Error: HTTP request failed"
        }
    }
}

final class APIManager {

    static var shared = APIManager()

    var urlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "singularitybooking.herokuapp.com"
        return components
    }()

    private let session: URLSession

    private init() {
        session = URLSession(configuration: .default)
    }

    func postRegister(credentials: Registration, completion: @escaping (Result<String?, Error>) -> Void) {
        var components = urlComponents
        components.path = "/api/v1/register"
        guard let url = components.url else {
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("*/*", forHTTPHeaderField: "Accept")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try? JSONEncoder().encode(credentials)

        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(error!))
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(APINetworkError.dataNotFound))
                }
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                DispatchQueue.main.async {
                    completion(.failure(APINetworkError.httpRequestFailed))
                }
                return
            }


            let message = String(data: data, encoding: .utf8)
            DispatchQueue.main.async {
                completion(.success(message))
            }

        }
        task.resume()
    }

//    func registerAPI(register: Registration, completionHandler: @escaping (Bool) -> ()) {
//
//        let header: HTTPHeaders = [.accept("*/*"), .contentType("application/json")]
//
//
//        AF.request(Constants.registerUrl, method: .post, parameters: register, encoder: JSONParameterEncoder.default, headers: header).response { response in
//            debugPrint(response.result)
//            //print(registerUrl)
//            switch response.result {
//            case.success(let data):
//               // print(data!)
//                do{
//                    //let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
//                    let json = try JSONSerialization.jsonObject(with: data!)
//                    print(json)
//                    if response.response?.statusCode == 200 {
//                        completionHandler(true)
//                    }else {
//                        completionHandler(false)
//                    }
//                }catch{
//                    print(error)
//                }
//            case.failure(let error):
//                print(error)
//                completionHandler(false)
//            }
//
//        }
//    }
//
//    func logInApi(login: LoginModel, completionHandler: @escaping (Bool) -> ()) {
//        let header: HTTPHeaders = [.accept("*/*"), .contentType("application/json")]
//
//        AF.request(loginUrl, method: .post, parameters: login, encoder: JSONParameterEncoder.default, headers: header).response { response in
//            debugPrint(response.result)
//            switch response.result {
//            case.success(let data):
//               // print(data!)
//                do{
//                    let json = try JSONSerialization.jsonObject(with: data!)
//                    print(json)
//                    if response.response?.statusCode == 200 {
//                        completionHandler(true)
//                    }else {
//                        completionHandler(false)
//                    }
//                }catch{
//                    print(error)
//                }
//            case.failure(let error):
//                print(error)
//                completionHandler(false)
//            }
//
//        }
//    }

}
