//
//  BookDateRoomViewController.swift
//  Booking
//
//  Created by Aigerim Abdurakhmanova on 24.06.2022.
//

import UIKit

class BookDateRoomViewController: UIViewController {

    @IBOutlet var roomNumberLabel: UILabel?
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var tableView: UITableView!
    
    var room: String = ""
    var token: String = ""
    var userId: Int!
    var date: String!
    
    private let networkManager: APIManager = .shared
    private var times: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomNumberLabel?.text = room
        datePicker.locale = .current
        datePicker.date = Date()
        datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
        print(self.times)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func dateSelected() {
            let dateFormatter = DateFormatter()
            //dateFormatter.dateStyle = .full
        dateFormatter.dateFormat = "yyyy-MM-dd"
            //dateFormatter.timeStyle = .short
            let date = dateFormatter.string(from: datePicker.date)
            print(date)
        networkManager.getAvailableTime(token: token, room: Int(room)!, date: date) { [weak self] result in
            guard let self = self else { return }
            self.times = result.availableTimeSlots
            self.tableView.reloadData()
            self.date = date
        }
    }
}

extension BookDateRoomViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        times.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "availableTableCell") as! AvailableTimesTableViewCell
        cell.label.text = times[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SendBookViewController") as! SendBookViewController
        vc.userId = userId
        vc.token = token
        vc.timeSlot = times[indexPath.row]
        vc.date = date
        vc.roomNumber = room
        navigationController?.pushViewController(vc, animated: true)
    }
}
