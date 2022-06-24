//
//  APIManager.swift
//  Booking
//
//  Created by Aigerim Abdurakhmanova on 23.06.2022.
//

import Foundation
import Alamofire

enum APINetworkError: Error {
    case dataNotFound
    case httpRequestFailed
}

struct Response: Codable {
    let id: String
    let username: String
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case token
    }
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

class APIManager {
    
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
           components.path = "/api/v1/sign-up"
           
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
    
    func postLogin(credentials: LoginModel, completion: @escaping (Result<String?, Error>) -> Void) {
        var components = urlComponents
        components.path = "/api/v1/sign-in"
        
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
    
    func postRoom(token: String, credentils: Book, completion: @escaping (Result<String?, Error>) -> Void) {
        var components = urlComponents
        components.path = "/api/v1/user/book"
        
        guard let url = components.url else {
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("*/*", forHTTPHeaderField: "Accept")
        urlRequest.setValue("Bearer_\(token)", forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try? JSONEncoder().encode(credentils)

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
    
    func getAvailableTime(token: String, room: Int, date: String, completion: @escaping (TimeSlots) -> Void) {
        var components = urlComponents
        components.path = "/api/v1/user/available-time/\(room)/\(date)"
        guard let url = components.url else {
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Bearer_\(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("*/*", forHTTPHeaderField: "Accept")
        
        urlRequest.httpMethod = "GET"
        print(urlRequest.headers)
    
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    print("ERROR calling get")
                    return
                }
                return
            }
            guard let data = data else {
                
                print("ERROR did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("HTTP request error \(response)")
                return
            }
            
            do {
                let times = try JSONDecoder().decode(TimeSlots.self, from: data)
                print("data \(data)")
                DispatchQueue.main.async {
                    completion(times)
                }
            }catch {
                print("no json")
               
            }

        }
        task.resume()
    }
    
    
    func getTimeSlots(token: String, userId: Int, completion: @escaping ([Booking]) -> Void) {
        var components = urlComponents
        components.path = "/api/v1/user/\(userId)/my-bookings"
        guard let url = components.url else {
            print("wronf url")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Bearer_\(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("*/*", forHTTPHeaderField: "Accept")
        urlRequest.httpMethod = "GET"
       
        let task = session.dataTask(with: urlRequest) { data, response, error in
                guard error == nil else {
                    print("ERROR calling get")
                    return
                }
            
                guard let data = data else {
                    print("ERROR did not receive data")
                    return
                }
            
                guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else{
                    print("HTTP request error \(response)")
                    return
                }
            
            do {
                let booking: [Booking] = try JSONDecoder().decode([Booking].self, from: data)
                print("data \(data)")
                DispatchQueue.main.async {
                    completion(booking)
                }
            }catch {
                print("no json")
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
        task.resume()
    }
}
