//
//  SendBookViewController.swift
//  Booking
//
//  Created by Aigerim Abdurakhmanova on 24.06.2022.
//

import UIKit

struct Book: Encodable {
    let userId: CLong
    let timeSlot: String
    let date: String
    let roomNumber: Int
    let purpose: String
}

class SendBookViewController: UIViewController {

    @IBOutlet private var textField: UITextField!
    
    var userId: CLong = 0
    var timeSlot: String = ""
    var date: String = ""
    var roomNumber: String = ""
    var purpose: String = ""
    var token:String = ""
    
    private let networkManager: APIManager = .shared
    
    @IBOutlet var logOutButton: UIButton!
    @IBOutlet var sendButton: UIButton!
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        timeLabel.text = timeSlot
        dateLabel.text = date
    }
    
    func setUpElements() {
        Utilities.styleFilledButton(sendButton)
        Utilities.styleHollowButton(logOutButton)
    }
    
    @IBAction func logOutTapped(_ sender: UIButton) {
        self.navigationController!.popToRootViewController(animated: true)
    }
    
    @IBAction func sendTapped(_ sender: UIButton) {
        
        guard let text = textField.text, textField.hasText else {return}
        
        let credentials = Book.init(userId: userId, timeSlot: timeSlot, date: date, roomNumber: Int(roomNumber)!, purpose: text)
        
        networkManager.postRoom(token: token, credentils: credentials) { [weak self] result in
            guard let self = self else { return }
            switch result {
                
            case let .success(message):
                let alert = UIAlertController(title: "Success", message: "Sent Successfully", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
            case let .failure(error):
                print(error)
            }
            
        }
    }
}
