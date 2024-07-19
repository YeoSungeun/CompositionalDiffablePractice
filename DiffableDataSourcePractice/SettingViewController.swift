//
//  SettingViewController.swift
//  DiffableDataSourcePractice
//
//  Created by 여성은 on 7/19/24.
//

import UIKit
import SnapKit

enum SettingOption: Int, CaseIterable {
    case all
    case personal
    case etc
    
    var mainOption: String {
        switch self {
        case .all:
            "전체 설정"
        case .personal:
            "개인 설정"
        case .etc:
            "기타"
        }
    }
    var subOptions: [String] {
        switch self {
        case .all:
            ["공지사항", "실험실", "버전 정보"]
        case .personal:
            ["개인/보안", "알림", "채팅" , "멀티프로필"]
        case .etc:
            ["고객센터/도움말"]
        }
    }
}

class SettingViewController: UIViewController {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    var registration: UICollectionView.CellRegistration<UICollectionViewListCell, String>!
    
    let list = SettingOption.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateView()
        configureDataSource()
    }
    func collectionViewLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        configuration.backgroundColor = .systemBackground
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    func configurateView() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        navigationItem.title = "설정"
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    func configureDataSource() {
        registration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier
            cell.contentConfiguration = content
            
            
        }
    }
}

extension SettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list[section].subOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: list[indexPath.section].subOptions[indexPath.item])
        return cell
    }
    
    
}
