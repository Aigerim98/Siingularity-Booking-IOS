//
//  CollectionViewCell.swift
//  Booking
//
//  Created by Aigerim Abdurakhmanova on 23.06.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet var roomImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(images: UIImageView) {
        roomImage = images
    }

}
