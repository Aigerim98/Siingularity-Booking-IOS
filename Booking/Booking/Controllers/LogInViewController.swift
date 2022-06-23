//
//  LogInViewController.swift
//  Booking
//
//  Created by Aigerim Abdurakhmanova on 23.06.2022.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var logInButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElelemnts()
    }
        
        func setUpElelemnts() {
            //Hide the error label
            //errorLabel.alpha = 0
            
            Utilities.styleTextField(firstNameTextField)
            
            Utilities.styleTextField(lastNameTextField)
            
            Utilities.styleFilledButton(logInButton)
        }

}
