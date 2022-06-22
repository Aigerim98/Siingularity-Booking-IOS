//
//  ProfileViewController.swift
//  SingularityBooking
//
//  Created by Aigerim Abdurakhmanova on 22.06.2022.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {

    @IBOutlet private var firstNameLabel: UILabel?
    @IBOutlet private var lastNameLabel: UILabel?
    @IBOutlet var logOutButton: UIButton!
    
    var firstName: String = ""
    var lastName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameLabel?.text = firstName
        lastNameLabel?.text = lastName
    
    }
    
    @IBAction func logOutTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func bookRoomTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookRoomViewController") as! BookRoomViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    func loadUser() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
    }
}
