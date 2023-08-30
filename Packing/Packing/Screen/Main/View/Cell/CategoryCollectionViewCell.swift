//
//  CategoryCollectionViewCell.swift
//  Packing
//
//  Created by 배은서 on 2023/08/29.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryCollectionViewCell"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(_ category: Place) {
        titleLabel.text = category.title
        itemCountLabel.text = "총 \(category.luggage.count)개의 짐"
    }
}
