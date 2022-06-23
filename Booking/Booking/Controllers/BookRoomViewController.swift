//
//  BookRoomViewController.swift
//  Booking
//
//  Created by Aigerim Abdurakhmanova on 23.06.2022.
//

import UIKit

class BookRoomViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    private var rooms: [Room] = [Room.init(number: "203", pictures: [UIImageView(image: UIImage(named: "floor2_1")), UIImageView(image: UIImage(named: "floor2_2")), UIImageView(image: UIImage(named: "floor2_3"))]),
                                 Room.init(number: "302", pictures: [UIImageView(image: UIImage(named: "303_1")), UIImageView(image: UIImage(named: "303_2")), UIImageView(image: UIImage(named: "303_3"))]),
                                 Room.init(number: "303", pictures: [UIImageView(image: UIImage(named: "floor3_1")), UIImageView(image: UIImage(named: "floor3_2")), UIImageView(image: UIImage(named: "floor3_3"))]),
                                 Room.init(number: "304", pictures: [UIImageView(image: UIImage(named: "mac_1")), UIImageView(image: UIImage(named: "mac_2")), UIImageView(image: UIImage(named: "mac_3"))]),
                                 Room.init(number: "404", pictures: [UIImageView(image: UIImage(named: "floor4_1")), UIImageView(image: UIImage(named: "floor4_2")), UIImageView(image: UIImage(named: "floor4_3"))])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TableViewCell", bundle: Bundle(for: TableViewCell.self)), forCellReuseIdentifier: "TableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension BookRoomViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        //cell.configureTableCell()
        cell.configureTableCell(with: rooms[indexPath.row])
        return cell
    }
}
