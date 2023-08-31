//
//  LuggageFooterView.swift
//  Packing
//
//  Created by 배은서 on 2023/08/31.
//

import UIKit

class LuggageFooterView: UITableViewHeaderFooterView {
    
    static let identifier = "LuggageFooterView"
    
    var touchedAddItemButton: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func touchUpAddButton(_ sender: Any) {
        touchedAddItemButton?()
    }
    
}
