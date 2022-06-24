//
//  LogInViewController.swift
//  Booking
//
//  Created by Aigerim Abdurakhmanova on 23.06.2022.
//

import UIKit

class LogInViewController: UIViewController {

   
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var logInButton: UIButton!
    var response: Response!
    var data: String!
    private let networkManager: APIManager = .shared
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElelemnts()
    }
        
    func setUpElelemnts() {
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(logInButton)
    }
    
    //Optional("{\"id\":57,\"username\":\"ali@gmail.com\",\"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhbGlAZ21haWwuY29tIiwicm9sZXMiOlsiUk9MRV9VU0VSIl0sImlhdCI6MTY1NjAwMDc1MCwiZXhwIjoxNjU5NjAwNzUwfQ.zEfOX2b2HHDu0ApVBxUMglSgfdczr_nVYMF771OIawg\"}")
    
    @IBAction func logInTapped(_ sender: Any) {
        let error = validateFields()
            
        if error != nil {
                //show error message
            print(error)
        } else {
            let email = emailTextField.text!
            let password = passwordTextField.text!
            
            let credentials = LoginModel(username: email, password: password)
            
            networkManager.postLogin(credentials: credentials) { [weak self] result in
                guard let self = self else { return }
                switch result {
                    
                case let .success(message):
                    // some toastview to show that user is registered
                    self.data = message
                    let temp = message?.dropFirst().dropLast()
                    
                    let array = temp?.components(separatedBy: ",")
                   
                    let firstNameArray = array![0].components(separatedBy: ":")
                    let firstName = firstNameArray[1].dropFirst().dropLast()
                    
                    let lastNameArray = array![1].components(separatedBy: ":")
                    let lastName = lastNameArray[1].dropFirst().dropLast()
                    
                    let separatedID = array![2].components(separatedBy: ":")
                    let separatedTokens = array![3].components(separatedBy: ":")
                    
                    
                    let id = separatedID[1]
                    let token = separatedTokens[1].dropFirst().dropLast()
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                    
                    vc.id = Int(id)
                    vc.token = String(token)
                    vc.firstName = String(firstName)
                    vc.lastName = String(lastName)
                    self.navigationController?.pushViewController(vc, animated: true)
                case let .failure(error):
                    print(error)
                }
            }
        }
        }
    

    func validateFields() -> String? {
            
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                
            return "Please fill all fields"
        }
            
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
//        if Utilities.isPasswordValid(cleanedPassword) == false {
//            return "PLease make sure your password is at least 8 charactes, contains a special character and number"
//        }
            
        if Utilities.isEmailValid(cleanedEmail) == false {
            return "Invalid email address"
        }

        return nil
    }
}

extension String {
    func componentsSeparatedByStrings(separators: [String]) -> [String] {
        return separators.reduce([self]) { result, separator in
            return result.flatMap { $0.components(separatedBy: separator) }
        }
        .map {
            $0.trimmingCharacters(in: .whitespaces)
        }
        
    }
}
