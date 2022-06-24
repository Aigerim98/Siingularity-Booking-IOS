//
//  TableViewCell.swift
//  Booking
//
//  Created by Aigerim Abdurakhmanova on 24.06.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
       
    @IBOutlet weak var roomNumberLabel: UILabel?
        //var room : Room!
        
    
    @IBOutlet weak var roomImageView: UIImageView?
    override func awakeFromNib() {
               super.awakeFromNib()
            
           }
    
        func configureTableCell(with rooms: Room) {
            roomNumberLabel?.text = rooms.number
            roomImageView?.image = UIImage(named: rooms.pictures)
            roomNumberLabel?.layer.cornerRadius = 2
        }
    }



