//
//  PlaceCollectionViewCell.swift
//  Packing
//
//  Created by 배은서 on 2023/08/29.
//

import UIKit

class PlaceCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PlaceCollectionViewCell"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 15
    }

    func setup(_ place: Place) {
        titleLabel.text = place.title
        let luggageCount = place.category.reduce(0) { total, category in
            total + category.itemList.count
        }
        itemCountLabel.text = "총 \(luggageCount)개의 짐"
    }
}
