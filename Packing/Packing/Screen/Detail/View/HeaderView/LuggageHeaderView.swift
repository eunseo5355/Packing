//
//  LuggageHeaderView.swift
//  Packing
//
//  Created by 배은서 on 2023/09/01.
//

import UIKit

class LuggageHeaderView: UITableViewHeaderFooterView {

    static let identifier = "LuggageHeaderView"
    
    var touchedEditButton: ((_ categoryTitle: String) -> ())?
    var didEndEditing: ((_ categoryTitle: String) -> ())?
    
    @IBOutlet weak var categoryTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTextField()
    }
    
    private func setTextField() {
        categoryTextField.delegate = self
        categoryTextField.isEnabled = false
    }
    
    func editTextField() {
        categoryTextField.isEnabled = true
        categoryTextField.becomeFirstResponder()
    }
    
    func setup(category: String) {
        categoryTextField.text = category
    }

    @IBAction func touchUpEditButton(_ sender: Any) {
        touchedEditButton?(categoryTextField.text ?? "")
    }
}

extension LuggageHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didEndEditing?(categoryTextField.text ?? "")
        categoryTextField.resignFirstResponder()
        return true
    }
}
