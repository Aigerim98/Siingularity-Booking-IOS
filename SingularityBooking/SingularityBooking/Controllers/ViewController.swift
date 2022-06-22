//
//  ViewController.swift
//  SingularityBooking
//
//  Created by Aigerim Abdurakhmanova on 22.06.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var logInButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElelemnts()
    }

    func setUpElelemnts() {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(logInButton)
    }
}

