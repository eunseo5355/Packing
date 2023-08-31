//
//  EditViewController.swift
//  Packing
//
//  Created by 배은서 on 2023/09/01.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "EditViewController"
    
    var touchedEditButton: (() -> ())?
    var touchedDeleteButton: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func touchUpEditButton(_ sender: Any) {
        touchedEditButton?()
    }
    
    @IBAction func touchUpDeleteButton(_ sender: Any) {
        touchedDeleteButton?()
    }
    
    func setTitle(item: String) {
        titleLabel.text = item
    }
    
}
