//
//  PlaceCollectionViewCell.swift
//  Packing
//
//  Created by 배은서 on 2023/08/29.
//

import UIKit

class PlaceCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PlaceCollectionViewCell"
    
    var touchedMoreButton: ((_ placeTitle: String) -> ())?
    var didEndEditing: ((_ placeTitle: String, _ editCompletion: (() -> ())) -> ())?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var itemCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTextField()
        layer.cornerRadius = 15
    }
    
    @IBAction func touchUpMoreButton(_ sender: Any) {
        touchedMoreButton?(placeTextField.text ?? "")
    }
    
    private func setTextField() {
        placeTextField.delegate = self
        placeTextField.isEnabled = false
    }
    
    func editTextField() {
        placeTextField.isEnabled = true
        placeTextField.becomeFirstResponder()
    }
    
    func setup(_ place: Place) {
        placeTextField.text = place.title
        let luggageCount = place.category.reduce(0) { total, category in
            total + category.itemList.count
        }
        itemCountLabel.text = "총 \(luggageCount)개의 짐"
    }
}

extension PlaceCollectionViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didEndEditing?(placeTextField.text ?? "") {
            placeTextField.isEnabled = false
        }
        placeTextField.resignFirstResponder()
        return true
    }
}
