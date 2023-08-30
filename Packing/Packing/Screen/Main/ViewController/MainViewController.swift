//
//  MainViewController.swift
//  Packing
//
//  Created by 배은서 on 2023/08/26.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Properties
    
    let dataManager = DataManager.shared
    
    //MARK: - UI Properties
    private let titleLabel: UILabel = {
        $0.text = "짐 싸자🎒"
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 23)
        return $0
    }(UILabel())
    
    private let categoryCollectionView = PlaceCollectionView()
    
    private lazy var addButton: UIButton = {
        $0.tintColor = .black
        var config = UIButton.Configuration.plain()
        config.preferredSymbolConfigurationForImage = .init(font: UIFont.systemFont(ofSize: 30))
        config.image = UIImage(systemName: "plus.circle.fill")
        $0.configuration = config
        $0.addTarget(self, action: #selector(touchUpAddButton), for: .touchUpInside)
        return $0
    }(UIButton())
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .white
        navigationItem.title = "Packing"
    }
    
    private func setupLayout() {
        [titleLabel, categoryCollectionView, addButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            categoryCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            addButton.trailingAnchor.constraint(equalTo: categoryCollectionView.trailingAnchor, constant: -10)
        ])
    }
    
    //MARK: - @objc
    
    @objc func touchUpAddButton() {
        let alert = UIAlertController(title: "새로운 항목 추가하기", message: nil, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "취소", style: .cancel)
        let addButton = UIAlertAction(title: "추가", style: .default) { _ in
            let newCategory = Place(title: alert.textFields?[0].text ?? "", luggage: [])
            self.dataManager.addCategory(newCategory)
            self.categoryCollectionView.collectionView.reloadData()
        }
        
        alert.addTextField()
        
        alert.addAction(cancelButton)
        alert.addAction(addButton)
        
        present(alert, animated: true)
    }
    
    // MARK: - Custom Method

}
