//
//  ProfileViewController.swift
//  Booking
//
//  Created by Aigerim Abdurakhmanova on 23.06.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet private var lastNameLabel: UILabel?
    @IBOutlet private var firstNameLabel: UILabel?
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var bookedRoomsLabel: UILabel!
    
    @IBOutlet var bookedRoomButton: UIButton!
    @IBOutlet var bookRoomButton: UIButton!
    
    private let networkManager: APIManager = .shared
    var bookings: [Booking] = []
    var firstName: String = ""
    var lastName: String = ""
    var id: Int?
    var token: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        firstNameLabel?.text = firstName
        lastNameLabel?.text = lastName
        
        loadBookings()
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 40
        print(bookings)
        // Do any additional setup after loading the view.
    }
    
    func setUpView() {
        Utilities.styleFilledButton(bookedRoomButton)
        Utilities.styleHollowButton(bookRoomButton)
    }
    @IBAction func bookRoomTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookRoomViewController") as! BookRoomViewController
        vc.token = self.token
        vc.userId = self.id
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension ProfileViewController {
    func loadBookings() {
        networkManager.getTimeSlots(token: token, userId: id!) { [weak self] booking in
            guard let self = self else {return}
           self.bookings = booking
            if booking.count > 0{
                self.bookedRoomsLabel.text = "Room: \(booking[0].room), time: \(booking[0].timeSlot!), date: \(booking[0].date!)  "
            } else {
                self.bookedRoomsLabel.text = "Does not have bookings"
            }
            print(booking)
        }
    }
}


