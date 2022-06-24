//
//  BookRoomViewController.swift
//  Booking
//
//  Created by Aigerim Abdurakhmanova on 23.06.2022.
//

import UIKit

class BookRoomViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    private var rooms: [Room] = [Room.init(number: "203", pictures: "floor2_1.jpg"), Room.init(number: "302", pictures: "303_1.jpg"), Room.init(number: "303", pictures: "floor3_1.jpg"), Room.init(number: "304", pictures: "mac_1.jpg"), Room.init(number: "404", pictures: "floor4_3.jpg")]
    
    var token: String = ""
    var userId: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // tableView.register(TableViewCell.self, forCellReuseIdentifier: "tableCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension BookRoomViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell
        //cell.configureTableCell()
        print(rooms[indexPath.row])
        cell.configureTableCell(with: rooms[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookDateRoomViewController") as! BookDateRoomViewController
        vc.room = rooms[indexPath.row].number
        vc.token = self.token
        vc.userId = self.userId
        navigationController?.pushViewController(vc, animated: true)
    }
}

