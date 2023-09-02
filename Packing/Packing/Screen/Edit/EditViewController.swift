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
    
    static func showModal(
        _ title: String,
        editHandler: @escaping (() -> ()),
        deleteHandler: @escaping (() -> ()))
    -> EditViewController {
        guard let editViewController = UIStoryboard(name: EditViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: EditViewController.identifier) as? EditViewController
        else { return EditViewController() }
        editViewController.modalPresentationStyle = .pageSheet
        
        if let sheetPresentationController = editViewController.presentationController as? UISheetPresentationController {
            sheetPresentationController.detents = [.custom { _ in
                return 250
            }]
            sheetPresentationController.prefersGrabberVisible = true
            sheetPresentationController.largestUndimmedDetentIdentifier = .medium
        }
        
        DispatchQueue.main.async {
            editViewController.setTitle(item: title)
        }
        
        editViewController.touchedDeleteButton = {
            deleteHandler()
            editViewController.dismiss(animated: true)
        }
        
        editViewController.touchedEditButton = {
            editViewController.dismiss(animated: true)
            editHandler()
        }
        
        return editViewController
    }
    
    func setTitle(item: String) {
        titleLabel.text = item
    }
    
}
