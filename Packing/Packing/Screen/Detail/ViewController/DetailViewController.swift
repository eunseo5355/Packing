//
//  DetailViewController.swift
//  Packing
//
//  Created by 배은서 on 2023/08/30.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Properties
    
    let dataManager = DataManager.shared
    
    var placeID = 0 {
        didSet {
            placeIndex = dataManager.placeList.firstIndex(where: { $0.id == placeID }) ?? 0
        }
    }
    var placeIndex = 0
    
    //MARK: - UI Properties
    
    private let placeLabel: UILabel = {
        $0.font = .boldSystemFont(ofSize: 23)
        return $0
    }(UILabel())
    
    private lazy var categoryAddButton: UIButton = {
        $0.tintColor = .blue
        $0.titleLabel?.font = .systemFont(ofSize: 13)
        $0.setTitle("카테고리 추가", for: .normal)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.addTarget(self, action: #selector(touchUpCategoryAddButton), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var luggageTableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupTableView()
        setupLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        navigationController?.navigationBar.tintColor = .darkGray
        view.backgroundColor = .white
        placeLabel.text = dataManager.placeList[placeIndex].title
        placeLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        categoryAddButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    private func setupTableView() {
        luggageTableView.dataSource = self
        luggageTableView.delegate = self
        
        let cellNib = UINib(nibName: LuggageTableViewCell.identifier, bundle: nil)
        luggageTableView.register(cellNib, forCellReuseIdentifier: LuggageTableViewCell.identifier)
        
        let headerNib = UINib(nibName: LuggageHeaderView.identifier, bundle: nil)
        luggageTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: LuggageHeaderView.identifier)
        
        let footerNib = UINib(nibName: LuggageFooterView.identifier, bundle: nil)
        luggageTableView.register(footerNib, forHeaderFooterViewReuseIdentifier: LuggageFooterView.identifier)
    }
    
    private func setupLayout() {
        [placeLabel, luggageTableView, categoryAddButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            placeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            placeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            placeLabel.trailingAnchor.constraint(equalTo: categoryAddButton.leadingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            categoryAddButton.centerYAnchor.constraint(equalTo: placeLabel.centerYAnchor),
            categoryAddButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            luggageTableView.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 5),
            luggageTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            luggageTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            luggageTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    //MARK: - @objc
    
    @objc func touchUpCategoryAddButton() {
        createAlert(title: "새로운 카테고리 추가하기") { newCategoryTitle in
            self.dataManager.addCategory(self.placeIndex, newCategoryTitle)
        }
    }
    
    // MARK: - Custom Method
    
    private func createAlert(title: String, completion: @escaping ((_ newTitle: String) -> Void)) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "취소", style: .cancel)
        let addButton = UIAlertAction(title: "추가", style: .default) { _ in
            guard let newTitle = alert.textFields?[0].text else { return }
            if newTitle.isEmpty { return }
            completion(newTitle)
            self.luggageTableView.reloadData()
        }
        
        alert.addTextField()
        
        alert.addAction(cancelButton)
        alert.addAction(addButton)
        
        present(alert, animated: true)
    }
    
//    private func edit(_ title: String, editHandler: @escaping (() -> ()), deleteHandler: @escaping (() -> ())) {
//        guard let editViewController = UIStoryboard(name: EditViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: EditViewController.identifier) as? EditViewController
//        else { return }
//        editViewController.modalPresentationStyle = .pageSheet
//
//        if let sheetPresentationController = editViewController.presentationController as? UISheetPresentationController {
//            sheetPresentationController.detents = [.custom { _ in
//                return 250
//            }]
//            sheetPresentationController.prefersGrabberVisible = true
//            sheetPresentationController.largestUndimmedDetentIdentifier = .medium
//        }
//
//        present(editViewController, animated: true)
//
//        editViewController.setTitle(item: title)
//        editViewController.touchedDeleteButton = {
//            deleteHandler()
//            editViewController.dismiss(animated: true) {
//                self.luggageTableView.reloadData()
//            }
//        }
//        editViewController.touchedEditButton = {
//            editViewController.dismiss(animated: true)
//            editHandler()
//        }
//    }

}

//MARK: - UITableViewDataSource

extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataManager.placeList[self.placeIndex].category.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.placeList[self.placeIndex].category[section].itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = luggageTableView.dequeueReusableCell(withIdentifier: LuggageTableViewCell.identifier) as? LuggageTableViewCell
        else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        
        cell.touchedCheckButton = {
            self.dataManager.completePacking(self.placeIndex, indexPath.section, indexPath.row)
            cell.setCheckButtonImage(self.dataManager.placeList[self.placeIndex].category[indexPath.section].itemList[indexPath.row].didPack)
            self.luggageTableView.reloadData()
        }

        cell.touchedMoreButton = { itemTitle in
            self.present(EditViewController.showModal(itemTitle,
                editHandler: {
                    cell.editTextField()
                },
                deleteHandler: {
                    self.dataManager.deleteItem(self.placeIndex, indexPath.section, indexPath.row)
                    self.luggageTableView.deleteRows(at: [indexPath], with: .fade)
                    self.luggageTableView.reloadData()
                }),
            animated: true)
        }
        
        // cell의 textField 수정이 끝났을 때 실행
        cell.didEndEditing = { itemTitel in
            if itemTitel.isEmpty {
                self.dataManager.deleteItem(self.placeIndex, indexPath.section, indexPath.row)
                self.luggageTableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                self.dataManager.editItemTitle(self.placeIndex, indexPath.section, indexPath.row, title: itemTitel)
            }
            self.luggageTableView.reloadData()
        }
        
        cell.setup(dataManager.placeList[self.placeIndex].category[indexPath.section].itemList[indexPath.row])
        
        return cell
    }
    
}

//MARK: - UITableViewDelegate

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = luggageTableView.dequeueReusableHeaderFooterView(withIdentifier: LuggageHeaderView.identifier) as? LuggageHeaderView
        else { return nil }
        
        headerView.setup(category: dataManager.placeList[placeIndex].category[section].title)
        
        headerView.touchedEditButton = { categoryTitle in
            self.present(EditViewController.showModal(categoryTitle,
                editHandler: {
                    headerView.editTextField()
                },
                deleteHandler: {
                    self.dataManager.deleteCategory(self.placeIndex, section)
                    self.luggageTableView.deleteSections([section], with: .fade)
                    self.luggageTableView.reloadData()
                }), animated: true)
        }
        
        headerView.didEndEditing = { categoryTitle in
            if categoryTitle.isEmpty {
                self.dataManager.deleteCategory(self.placeIndex, section)
                self.luggageTableView.deleteSections([section], with: .fade)
            } else {
                self.dataManager.editCategoryTitle(self.placeIndex, section, title: categoryTitle)
            }
            self.luggageTableView.reloadData()
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerView = luggageTableView.dequeueReusableHeaderFooterView(withIdentifier: LuggageFooterView.identifier) as? LuggageFooterView
        else { return nil }
        
        footerView.touchedAddItemButton = {
            self.createAlert(title: "새로운 물품 추가") { newItemTitle in
                self.dataManager.addItem(self.placeIndex, section, title: newItemTitle)
            }
        }
        
        return footerView
    }
    
}
