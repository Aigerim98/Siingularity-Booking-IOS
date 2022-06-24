//
//  ViewController.swift
//  Booking
//
//  Created by Aigerim Abdurakhmanova on 23.06.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var logInButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElelemnts()
    }
    @IBAction func signUpTapped(_ sender: Any) {
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
           self.navigationController?.pushViewController(vc, animated: true)
       }
       
       @IBAction func logInTapped(_ sender: Any) {
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
           navigationController?.pushViewController(vc, animated: true)
       }
       func setUpElelemnts() {
           Utilities.styleFilledButton(signUpButton)
           Utilities.styleHollowButton(logInButton)
       }

}

