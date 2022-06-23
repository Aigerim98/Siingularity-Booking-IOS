//
//  SignUpViewController.swift
//  Booking
//
//  Created by Aigerim Abdurakhmanova on 23.06.2022.
//

import UIKit

class SignUpViewController: UIViewController {

    var userMails: [String] = []
        
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var errorLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
            
        setUpElelemnts()
    }
        
    @IBAction func singUpButtonTapped(_ sender: UIButton){
        let error = validateFields()
            
        if error != nil {
                //show error message
            showError(error!)
        } else {
            let firstName = firstNameTextField.text!
            let lastName = lastNameTextField.text!
            let email = emailTextField.text!
            let password = passwordTextField.text!
            
            let register = Registration(firstName: firstName, lastName: lastName, email: email, password: password)
            print(register)
            APIManager.shareInstance.registerAPI(register: register) {
                (isSucess) in
                if isSucess {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        //            vc.firstName = firstName
        //            vc.lastName = lastName
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    print("try again")
                }
            }
        
        }
    }

    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
        
    func validateFields() -> String? {
            
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                
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
        
    func setUpElelemnts() {
            //Hide the error label
        errorLabel.alpha = 0
            
        Utilities.styleTextField(firstNameTextField)
            
        Utilities.styleTextField(lastNameTextField)
            
        Utilities.styleTextField(emailTextField)
            
        Utilities.styleTextField(passwordTextField)
            
        Utilities.styleFilledButton(signUpButton)
    }
        

}
