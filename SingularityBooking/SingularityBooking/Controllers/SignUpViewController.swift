//
//  SignUpViewController.swift
//  SingularityBooking
//
//  Created by Aigerim Abdurakhmanova on 22.06.2022.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {

    var users: [NSManagedObject] = []
    var mails: [String] = []
    
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
            saveUser(firstName, lastName, email, password)
            print(mails)
            if mails.contains(email){
                let alert = UIAlertController(title: "Account Exists", message: "There is an account with this email address.", preferredStyle: .alert)
                           // add an action (button)
                           //alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                           let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                                   UIAlertAction in
                                   _ = self.navigationController?.popViewController(animated: true)
                               }
                           alert.addAction(okAction)
                           // show the alert
                           self.present(alert, animated: true, completion: nil)
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                vc.firstName = firstName
                vc.lastName = lastName
                navigationController?.pushViewController(vc, animated: true)
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
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "PLease make sure your password is at least 8 charactes, contains a special character and number"
        }
        
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
    
    func saveUser(_ firstName: String, _ lastName: String, _ email: String, _ password: String
    ) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        let user = NSManagedObject(entity: entity, insertInto: managedContext)
        user.setValue(firstName, forKey: "firstName")
        user.setValue(lastName, forKey: "lastName")
        user.setValue(email, forKey: "email")
        user.setValue(password, forKey: "password")
        
        do {
            try managedContext.save()
            users.append(user)
            mails.append(email)
        } catch let error as NSError {
            print("Could not save")
        }
    }
}
