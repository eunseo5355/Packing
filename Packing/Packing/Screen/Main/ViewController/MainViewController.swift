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
    
    private let placeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
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
        setupCollectionView()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        placeCollectionView.reloadData()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .white
        navigationItem.title = "Packing"
    }
    
    private func setupCollectionView() {
        placeCollectionView.delegate = self
        placeCollectionView.dataSource = self
        let nib = UINib(nibName: PlaceCollectionViewCell.identifier, bundle: nil)
        placeCollectionView.register(nib, forCellWithReuseIdentifier: PlaceCollectionViewCell.identifier)
        placeCollectionView.showsVerticalScrollIndicator = false
    }
    
    private func setupLayout() {
        [titleLabel, placeCollectionView, addButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            placeCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            placeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            placeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            placeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            addButton.trailingAnchor.constraint(equalTo: placeCollectionView.trailingAnchor, constant: -10)
        ])
    }
    
    //MARK: - @objc
    
    @objc func touchUpAddButton() {
        let alert = UIAlertController(title: "새로운 항목 추가하기", message: nil, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "취소", style: .cancel)
        let addButton = UIAlertAction(title: "추가", style: .default) { _ in
            guard let newPlaceTitle = alert.textFields?[0].text else { return }
            if newPlaceTitle.isEmpty { return }
            self.dataManager.addPlace(newPlaceTitle)
            self.placeCollectionView.reloadData()
        }
        
        alert.addTextField()
        
        alert.addAction(cancelButton)
        alert.addAction(addButton)
        
        present(alert, animated: true)
    }
    
    // MARK: - Custom Method

}

//MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.placeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceCollectionViewCell.identifier, for: indexPath) as? PlaceCollectionViewCell
        else { return UICollectionViewCell() }
    
        cell.setup(dataManager.placeList[indexPath.row])
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.placeID = dataManager.placeList[indexPath.row].id
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 35) / 2, height: (view.frame.width - 35) / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 아이템 행 사이의 간격 설정
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 아이템 사이의 간격 설정
        return 15
    }
}
