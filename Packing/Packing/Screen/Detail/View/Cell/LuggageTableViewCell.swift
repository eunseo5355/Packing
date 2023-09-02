//
//  LuggageTableViewCell.swift
//  Packing
//
//  Created by 배은서 on 2023/08/31.
//

import UIKit

class LuggageTableViewCell: UITableViewCell {
    
    static let identifier = "LuggageTableViewCell"
    
    var touchedCheckButton: (() -> ())?
    var touchedMoreButton: ((_ itemTitle: String) -> ())?
    var didEndEditing: ((_ itemTitle: String) -> ())?

    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var editButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTextField()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func touchUpCheckButton(_ sender: Any) {
        touchedCheckButton?()
    }
    
    @IBAction func touchUpMoreButton(_ sender: Any) {
        touchedMoreButton?(itemTextField.text ?? "")
    }
    
    private func setTextField() {
        itemTextField.delegate = self
        itemTextField.isEnabled = false
    }
    
    func editTextField() {
        itemTextField.isEnabled = true
        itemTextField.becomeFirstResponder()
    }
    
    func setCheckButtonImage(_ didPack: Bool) {
        checkButton.setImage(didPack ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "square"), for: .normal)
    }
    
    func setup(_ item: Item) {
        setCheckButtonImage(item.didPack)
        itemTextField.text = item.title
    }
}

extension LuggageTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didEndEditing?(itemTextField.text ?? "")
        itemTextField.resignFirstResponder()
        return true
    }
}
